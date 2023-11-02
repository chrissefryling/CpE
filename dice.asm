#include "qm_common.h"
#include "qm_pinmux.h"
#include "qm_pin_functions.h"
#include "qm_uart.h"

char Begin[10] = "Begin:$";
char menu1[30] = "Enter 1 for Easy $";
char menu2[30] = "Enter 2 for Medium $";
char menu3[30] = "Enter 3 for Hard $";
char menu4[25] = "Try again $";
char menu5[41] = "The winner is player one, play again? $";
char menu7[41] = "The winner is player two, play again? $";
char menu8[41] = "The winner is player three, play again? $";
char menu9[41] = "The winner is player four, play again? $";
char menu6[30] = "Loser, try again?$";

int main()
{
__asm__(".intel_syntax noprefix\n\t"

//SERIAL CABLE FUNCTIONS - 2
"mov edx, 2  \n\t" //MUX function 2 (SERIAL)
"mov eax, 12  \n\t" //IO PIN number (TX)
"call qm_pmux_select  \n\t"
"mov edx, 2  \n\t" //MUX function 2 (SERIAL)
"mov eax, 13  \n\t" //IO PIN number (RX)
"call qm_pmux_select  \n\t"

//LED FUNCTION - 0
"mov edx, 0 \n\t"
"mov eax, 0 \n\t"
"call qm_pmux_select \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 3  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 4  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 5  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 6  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 7  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 8  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 9  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 10  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 11  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 14  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"
"mov edx, 0  \n\t" //MUX function 0 (GPIO)
"mov eax, 15  \n\t" //IO PIN number
"call qm_pmux_select  \n\t"

"mov dx, 0b0001011111111000 \n\t"
"mov [0xb0000c04], edx  \n\t"

"lea edi,Begin  \n\t"
"call Printing \n\t"
"call main_menu \n\t"


"main_menu:  \n\t"
"lea edi,menu1  \n\t"
"call Printing  \n\t"
"lea edi,menu2  \n\t"
"call Printing  \n\t"
"lea edi,menu3  \n\t"
"call Printing  \n\t"

 ".MM_WAIT_FOR_KEYSTROKE:  \n\t"
 "mov al,[0xb0002014] \n\t"
 "and al,0x1 \n\t"
 "cmp al,0  \n\t"
 "je .MM_WAIT_FOR_KEYSTROKE  \n\t"


"mov ebx,[0xB0002000] \n\t"
"cmp bl,'1' \n\t"
"jne .SA_1   \n\t"
"call Mode1 \n\t"



".SA_1:  \n\t"
"cmp bl, '2'  \n\t"
"jne .SA_2  \n\t"
"call Mode2 \n\t"

".SA_2:  \n\t"
"cmp bl,'3'  \n\t"
"jne .TryAgain  \n\t"
"call Mode3 \n\t"

".TryAgain:   \n\t"
"lea edi,menu4 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"


"Mode1: \n\t"
"mov dh, 0b10000000 \n\t"


".Leds1: \n\t"
"call EasyModeSpeed  \n\t"
"call check \n\t"
"ror dh,1 \n\t"
"jmp .Leds1 \n\t"
"ret \n\t"


"Mode2: \n\t"
"mov dh, 0b10000000 \n\t"


".Leds2: \n\t"
"call MediumModeSpeed \n\t"
"call checkm \n\t"
"ror dh,1 \n\t"
"jmp .Leds2 \n\t"
"ret \n\t"

"Mode3: \n\t"
"mov dh, 0b10000000 \n\t"


".Leds3: \n\t"
"call HardModeSpeed  \n\t"
"call checkh \n\t"
"ror dh,1 \n\t"
"jmp .Leds3 \n\t"
"ret \n\t"



"FirstDelay: \n\t"
"push ecx \n\t"
"mov ecx, 888889 \n\t"
".2: \n\t"
"nop  \n\t"
"dec ecx  \n\t"
"cmp ecx, 0  \n\t"
"jne .2 \n\t"
"pop ecx \n\t"
"ret \n\t"

"SecondDelay: \n\t"
"push ecx \n\t"
"mov ecx, 444444 \n\t"
".2a: \n\t"
"nop  \n\t"
"dec ecx  \n\t"
"cmp ecx, 0  \n\t"
"jne .2a \n\t"
"pop ecx \n\t"
"ret \n\t"

"ThirdDelay: \n\t"
"push ecx \n\t"
"mov ecx, 222222 \n\t"
".2b: \n\t"
"nop  \n\t"
"dec ecx  \n\t"
"cmp ecx, 0  \n\t"
"jne .2b \n\t"
"pop ecx \n\t"
"ret \n\t"


"check: \n\t"
"1: \n\t"
    "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100100000000000 \n\t"
"jne 2f \n\t"
"cmp dh, 0b00000010 \n\t"
"je Winner1 \n\t"
"call LOST \n\t"


"2: \n\t"
 "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100000000000001 \n\t"
"jne 3f \n\t"
"cmp dh, 0b00001000 \n\t"
"je Winner2 \n\t"
"call LOST \n\t"

"3: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1000100000000001 \n\t"
"jne 4f \n\t"
"cmp dh, 0b00100000 \n\t"
"je Winner3 \n\t"
"call LOST \n\t"

"4: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b0100100000000001 \n\t"
"jne 5f \n\t"
"cmp dh, 0b10000000 \n\t"
"je Winner4 \n\t"
"call LOST \n\t"

"5: \n\t"
"ret \n\t"
"checkm: \n\t"


"6: \n\t"
    "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100100000000000 \n\t"
"jne 7f \n\t"
"cmp dh, 0b00000010 \n\t"
"je Winner1 \n\t"
"call LOST \n\t"

"7: \n\t"
 "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100000000000001 \n\t"
"jne 8f \n\t"
"cmp dh, 0b00001000 \n\t"
"je Winner2 \n\t"
"call LOST \n\t"

"8: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1000100000000001 \n\t"
"jne 9f \n\t"
"cmp dh, 0b00100000 \n\t"
"je Winner3 \n\t"
"call LOST \n\t"

"9: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b0100100000000001 \n\t"
"jne 10f \n\t"
"cmp dh, 0b10000000 \n\t"
"je Winner4 \n\t"
"call LOST \n\t"


"10: \n\t"
"ret \n\t"
"checkh: \n\t"

"11: \n\t"
    "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100100000000000 \n\t"
"jne 12f \n\t"
"cmp dh, 0b00000010 \n\t"
"je Winner1 \n\t"
"call LOST \n\t"

"12: \n\t"
 "mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1100000000000001 \n\t"
"jne 13f \n\t"
"cmp dh, 0b00001000 \n\t"
"je Winner2 \n\t"
"call LOST \n\t"

"13: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b1000100000000001 \n\t"
"jne 14f \n\t"
"cmp dh, 0b00100000 \n\t"
"je Winner3 \n\t"
"call LOST \n\t"

"14: \n\t"
"mov ebx, [0x0B0000C50] \n\t"
"and bx, 0b1100100000000001 \n\t"
"cmp bx, 0b0100100000000001 \n\t"
"jne 15f \n\t"
"cmp dh, 0b10000000 \n\t"
"je Winner4 \n\t"
"call LOST \n\t"

"15: \n\t"
"ret \n\t"

"EasyModeSpeed:  \n\t"
"ror dx,5  \n\t"
"mov [0xb0000c00], dx  \n\t"
"rol dx,5  \n\t"
"call FirstDelay \n\t"
"ret  \n\t"

"MediumModeSpeed:  \n\t"
"ror dx,5  \n\t"
"mov [0xb0000c00], dx  \n\t"
"rol dx,5  \n\t"
"call SecondDelay \n\t"
"ret  \n\t"

"HardModeSpeed:  \n\t"
"ror dx,5  \n\t"
"mov [0xb0000c00], dx  \n\t"
"rol dx,5  \n\t"
"call ThirdDelay \n\t"
"ret  \n\t"

"LOST: \n\t"
"lea edi,menu6 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"

"Winner1: \n\t"
"lea edi,menu5 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"

"Winner2: \n\t"
"lea edi,menu7 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"

"Winner3: \n\t"
"lea edi,menu8 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"

"Winner4: \n\t"
"lea edi,menu9 \n\t"
"call Printing  \n\t"
"jmp main_menu \n\t"


"Printing:  \n\t"
"push eax \n\t"
"push edx  \n\t"


".Printing2:  \n\t"
"mov eax,0  \n\t"
"mov dl,[edi] \n\t"
"cmp dl,'$' \n\t"
"je .Ending  \n\t"
"call qm_uart_write  \n\t"
"inc edi  \n\t"
"jmp .Printing2 \n\t"


".Ending:  \n\t"
"mov eax,0  \n\t"
"mov dl,0x0a \n\t"
"call qm_uart_write  \n\t"
"mov eax,0  \n\t"
"mov dl,0xd  \n\t"
"call qm_uart_write  \n\t"


"pop edx  \n\t"
"pop eax  \n\t"
"ret \n\t"
".att_syntax \n\t");


  return 0;
}



