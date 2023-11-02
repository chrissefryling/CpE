//CodeLab8

#include "qm_common.h"
#include "qm_pinmux.h"
#include "qm_pin_functions.h"
#include "qm_uart.h"

char openmessage[27] = "Please Enter the Password:$";
char incorrect[20] = "Incorrect Password$";
char pass[20] = "cpe$"; //just note, the user doesn't have to type the '$' for a correct password input
//the $ is just a termination character used as a helper in your check_user_pass subroutine.
char menu1[30] = "Enter 1 for Pattern 1 $";
char menu2[30] = "Enter 2 for Pattern 2 $";
char menu3[30] = "Enter 3 for Pattern 3 $";
char menu4[30] = "Press any other key to quit $";
char menu4_resp[30] = "Goodbye!$";
char userpass[20]; //empty array of 20 bytes used to save the user's keyboard input



int main()
{
__asm__(".intel_syntax noprefix\n\t"

//SERIAL CABLE FUNCTIONS - 2
"mov edx, 2 \n\t" //MUX function 2 (SERIAL)
"mov eax, 12 \n\t" //IO PIN number (TX)
"call qm_pmux_select \n\t"
"mov edx, 2 \n\t" //MUX function 2 (SERIAL)
"mov eax, 13 \n\t" //IO PIN number (RX)
"call qm_pmux_select \n\t"

//LED FUNCTION - 0
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 3 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 4 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 5 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 6 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 7 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 8 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 9 \n\t" //IO PIN number
"call qm_pmux_select \n\t"
"mov edx, 0 \n\t" //MUX function 0 (GPIO)
"mov eax, 10 \n\t" //IO PIN number
"call qm_pmux_select \n\t"

"mov dx, 0b1101111111111111 \n\t" //13th bit is RX, which is an input, therefore 0
"mov [0xb0000c04], edx \n\t" //set I/O line dir.

"lea edi,openmessage \n\t"
"call print_string \n\t"
"call get_pass_sub \n\t"
"call check_user_pass \n\t"
"call main_menu \n\t"
"hlt \n\t"








"get_pass_sub: \n\t" //get password subroutine
"lea edi,userpass  \n\t"
 ".M_WAIT_FOR_KEYSTROKE: \n\t" // waiting for the key to be pressed , one
 "mov al,[0xb0002014] \n\t" // assign al to address memory
 "and al,0x1 \n\t" // input
"cmp al,0 \n\t" // comparing if it is an input or output
 "je .M_WAIT_FOR_KEYSTROKE  \n\t" // jump back to wait instruction , one
 "mov edx, [0xB0002000] \n\t" // assigning edx
"mov [edi], dl  \n\t" // move content of dl into memory add of edi
"cmp dl, 0xd \n\t" // compare
"je .HH  \n\t" // jump forward
"mov eax,0 \n\t" //
"mov dl, '*' \n\t" //writing *
" call qm_uart_write \n\t" //printing the * as the user enters the pass
"inc edi \n\t"
"jmp .M_WAIT_FOR_KEYSTROKE  \n\t"
".HH: \n\t"// assigning the jump for the HH
"mov eax,0 \n\t"
"mov dl, 0xd \n\t"
" call qm_uart_write \n\t" //printing
"mov dl, 0xa \n\t"
" call qm_uart_write \n\t"//printing
"ret \n\t" //return from procedure








"check_user_pass: \n\t"
".P: \n\t" // assign a loop , jump
"lea edi,userpass  \n\t" //move the empty array into the reg
"lea esi,pass \n\t" // move the pass array into esi reg
".T: \n\t" // assigning a jump,loop
"mov eax, [edi] \n\t" // move the content of edi which is userpass into eax
"mov ebx,[esi] \n\t" //moving the data in memory location of esi into a reg ebx
"inc edi \n\t" //increment edi
"inc esi \n\t" // increment esi
"cmp al, bl \n\t" //comparing the saved password and what the user entered
"je  .T \n\t" //jump
"cmp bl,'$' \n\t" // comparing to  terminations
"je .I \n\t" //jump to I
"lea edi,incorrect \n\t" // load the array incorrect into reg edi
"call print_string \n\t" //printing that the pass is incorrect
"lea edi,openmessage  \n\t" //allowing the user to enter the password again
"call print_string \n\t" // printing
"call get_pass_sub \n\t" //
"jmp .P \n\t"

".I: \n\t"
"ret \n\t"









"main_menu: \n\t"
"call turnoff_leds  \n\t"
"lea edi,menu1  \n\t"
"call print_string  \n\t"
"lea edi,menu2  \n\t"
"call print_string  \n\t"
"lea edi,menu3  \n\t"
"call print_string  \n\t"
"lea edi,menu4  \n\t"
"call print_string  \n\t"

".MM_WAIT_FOR_KEYSTROKE:  \n\t"
"mov al,[0xb0002014] \n\t"
"and al,0x1 \n\t"
"cmp al,0  \n\t"
"je .MM_WAIT_FOR_KEYSTROKE  \n\t"


"mov ebx,[0xB0002000] \n\t" //grab user-typed char from buffer
"cmp bl,'1' \n\t"  //did the user type the enter key (aka carriage return in ascii?)
"jne .2_key   \n\t"
//"lea edi,menu1  \n\t"
"call pat1  \n\t"
"jmp .MM_WAIT_FOR_KEYSTROKE  \n\t"

".2_key:  \n\t"
"cmp bl, '2'  \n\t"
"jne .3_key  \n\t"
//"lea edi,menu2  \n\t"
"call pat2  \n\t"
"jmp .MM_WAIT_FOR_KEYSTROKE  \n\t"

".3_key:  \n\t"
"cmp bl,'3'  \n\t"
"jne .quit  \n\t"
//"lea edi,menu3  \n\t"
"call pat3  \n\t"
"jmp .MM_WAIT_FOR_KEYSTROKE  \n\t"

".quit:   \n\t"
"lea edi,menu4_resp  \n\t"
"call print_string  \n\t"
"ret \n\t"

"print_string: \n\t"
"push eax \n\t" //now I can overwrite eax without worry
"push edx  \n\t" //now I can overwrite edx without worry
".print_loop:  \n\t"
"mov eax,0  \n\t"
"mov dl,[edi] \n\t"
"cmp dl,'$' \n\t"
"je .end_print_sub  \n\t"
"call qm_uart_write  \n\t"
"inc edi  \n\t" //increment index to next mem addr
"jmp .print_loop \n\t"
".end_print_sub:  \n\t"
"mov eax,0  \n\t" //sometimes uart_write doesn't work w/o eax=0
"mov dl,0x0a \n\t" //new line character
"call qm_uart_write  \n\t"
"mov eax,0  \n\t" //sometimes uart_write doesn't work w/o eax=0
"mov dl,0xd  \n\t"
"call qm_uart_write  \n\t" //begin cursor at far left column

//pop regs in LIFO order
"pop edx  \n\t" //restore edx before sub call
"pop eax  \n\t" //restore eax before sub call
"ret \n\t"

"pat3: \n\t"
"mov edx, 0  \n\t" //clear out EDX
"mov ax,0x00f0 \n\t"
"mov bx,0x0f00 \n\t"

"mov dh,ah \n\t"
"or dh,bl \n\t"
"call output_leds  \n\t" //includes delay subroutine call!
".LEDLOOP3: \n\t"
"rol ax,1 \n\t"
"ror bx,1 \n\t"
"mov dh,ah \n\t"
"AND dh,bl \n\t"
"call output_leds  \n\t"
"cmp dh,0xff \n\t"
"jne .LEDLOOP3 \n\t"
"call turnoff_leds  \n\t"
"ret    \n\t"


"output_leds: \n\t"
"ror dx,5  \n\t"
"mov [0xb0000c00], dx  \n\t" //includes delay subroutine call!
"rol dx,5  \n\t"
"call delay \n\t"
"ret \n\t"

"turnoff_leds: \n\t"
"mov dx,0x0000  \n\t"
"mov [0xb0000c00], dx  \n\t"
"call delay \n\t"
"ret \n\t"

"pat2: \n\t"
"mov edx, 0  \n\t"
"mov dh, 0b10000000 \n\t"
".LEDLOOP2: \n\t"
"call output_leds  \n\t"
"ror dh,1 \n\t"
"cmp dh,0b00000001 \n\t"
"jne .LEDLOOP2 \n\t"

".LOOPLEFT: \n\t"
"call output_leds  \n\t"
"rol dh,0x1 \n\t"
"cmp dh,0b10000000 \n\t"
"jne .LOOPLEFT \n\t"
"call output_leds  \n\t"
"call turnoff_leds  \n\t"
"ret    \n\t"

"pat1: \n\t"
"mov edx, 0  \n\t" //clear out EDX
"mov dh, 0b01000010 \n\t"
"mov ecx,0  \n\t"
".LEDLOOP1: \n\t"
"call output_leds  \n\t"
"not dh \n\t"
"inc ecx \n\t"
"cmp ecx,8 \n\t"
"jne .LEDLOOP1 \n\t"
"call turnoff_leds  \n\t"
"ret    \n\t"


"delay: \n\t"
"push ecx \n\t"
"mov ecx, 3560000    \n\t"
".DELAYLOOP:      \n\t"
"nop      \n\t" //waste time
"dec ecx     \n\t" //decrement bx counter
"cmp ecx,0   \n\t" //reached end of bx?
"jne .DELAYLOOP      \n\t"
"pop ecx \n\t"
"ret \n\t"


".att_syntax \n\t");



  return 0;
}
