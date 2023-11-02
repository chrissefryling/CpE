
#include "qm_common.h"
#include "qm_pinmux.h"
#include "qm_pin_functions.h"
#include "qm_uart.h"

//messages to present to user
char mesg[27] = "Please Enter the Password:$";
char wrongPass[20] = "Wrong Password$";
char menu1[30] = "Enter 1 for Pattern 1 $";
char menu2[30] = "Enter 2 for Pattern 2 $";
char menu3[30] = "Enter 3 for Pattern 3 $";
char menu4[30] = "Press any other key to quit $";
char menu4_resp[30] = "Goodbye!$";

char userInput[20]; // user input
char password[20] = "cpe$"; // password



int main()
{
		__asm__(".intel_syntax noprefix\n\t"

		"mov edx, 2 \n\t"
		"mov eax, 12 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 2 \n\t"
		"mov eax, 13 \n\t"
		"call qm_pmux_select \n\t"

		//LEDS
		"mov edx, 0 \n\t"
		"mov eax, 3 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 4 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 5 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 6 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 7 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 8 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 9 \n\t"
		"call qm_pmux_select \n\t"
		"mov edx, 0 \n\t"
		"mov eax, 10 \n\t"
		"call qm_pmux_select \n\t"

		//set input/output
		"mov dx, 0b1101111111111111 \n\t"
		"mov [0xb0000c04], edx \n\t"

		// Checking password and printing menu if correct
		"lea edi,mesg \n\t"
		"call print_string \n\t"
		"call get_pass_sub \n\t"
		"call check_user_pass \n\t"
		"call main_menu \n\t"
		"hlt \n\t"

		// Getting Password
		"get_pass_sub: \n\t"
		"lea edi,userInput  \n\t"
		 ".WAIT_FOR_KEYSTROKE: \n\t"
		 "mov al,[0xb0002014] \n\t"
		 "and al,0x1 \n\t"
		"cmp al,0 \n\t"
		 "je .WAIT_FOR_KEYSTROKE  \n\t"
		 "mov edx, [0xB0002000] \n\t"
		"mov [edi], dl  \n\t"
		"cmp dl, 0xd \n\t"
		"je .one  \n\t"
		"mov eax,0 \n\t"
		//printing ***
		"mov dl, '*' \n\t"
		" call qm_uart_write \n\t"
		"inc edi \n\t"
		"jmp .WAIT_FOR_KEYSTROKE  \n\t"
		".one: \n\t"
		"mov eax,0 \n\t"
		"mov dl, 0xd \n\t"
		//printing
		" call qm_uart_write \n\t"
		"mov dl, 0xa \n\t"
		" call qm_uart_write \n\t"
		"ret \n\t" //return

		//checking the password
		"check_user_pass: \n\t"
		".two: \n\t" // begin loop
		//create empty array & move password into esi
		"lea edi,userInput  \n\t"
		"lea esi,password \n\t"
		".three: \n\t"
		"mov eax, [edi] \n\t"
		"mov ebx,[esi] \n\t"
		//increment edi & esi
		"inc edi \n\t"
		"inc esi \n\t"
		//actually comparing the password to user input
		"cmp al, bl \n\t"
		"je  .three \n\t"
		// looks for $
		"cmp bl,'$' \n\t"
		"je .four \n\t"
		//if the password is incorrect
		"lea edi,wrongPass \n\t"
		"call print_string \n\t"
		"lea edi,mesg  \n\t"
		"call print_string \n\t"
		"call get_pass_sub \n\t"
		"jmp .two \n\t"

		".four: \n\t"
		"ret \n\t"

		// main menu
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

		".WAIT_FOR_KEYSTROKE1:  \n\t"
		"mov al,[0xb0002014] \n\t"
		"and al,0x1 \n\t"
		"cmp al,0  \n\t"
		"je .WAIT_FOR_KEYSTROKE1  \n\t"

		//user typing
		"mov ebx,[0xB0002000] \n\t"
		"cmp bl,'1' \n\t"
		"jne .2_key   \n\t"
		"call pat1  \n\t"
		"jmp .WAIT_FOR_KEYSTROKE1  \n\t"
		".2_key:  \n\t"
		"cmp bl, '2'  \n\t"
		"jne .3_key  \n\t"
		"call pat2  \n\t"
		"jmp .WAIT_FOR_KEYSTROKE1  \n\t"
		".3_key:  \n\t"
		"cmp bl,'3'  \n\t"
		"jne .quit  \n\t"
		"call pat3  \n\t"
		"jmp .WAIT_FOR_KEYSTROKE1  \n\t"
		".quit:   \n\t"
		"lea edi,menu4_resp  \n\t"
		"call print_string  \n\t"
		"ret \n\t"

		//printing strings
		"print_string: \n\t"
		"push eax \n\t" //now I can overwrite eax without worry
		"push edx \n\t" //now I can overwrite edx without worry
		".print_loop: \n\t"
		"mov dl,[edi] \n\t"
		"cmp dl, '$'; \n\t"
		"je .end_print_sub \n\t"
		"mov eax,0 + \n\t" //sometimes uart_write doesn't work w/o eax=0
		"call qm_uart_write \n\t"
		"inc edi \n\t" //increment index to next mem addr
		"jmp .print_loop \n\t"
		".end_print_sub: \n\t"
		"mov dl,0x0a \n\t" //new line character
		"call qm_uart_write \n\t"
		//pop regs in LIFO order
		"pop edx \n\t" //restore edx before sub call
		"pop eax \n\t" //restore eax before sub call
		"ret \n\t"

		// pattern three
		"pat3: \n\t"
		"mov edx, 0  \n\t"
		"mov ax,0x00f0 \n\t"
		"mov bx,0x0f00 \n\t"

		"mov dh,ah \n\t"
		"or dh,bl \n\t"
		"call output_leds  \n\t"
		".3b: \n\t"
		"ROL ax,1 \n\t"
		"ROR bx,1 \n\t"
		"mov dh,ah \n\t"
		"AND dh,bl \n\t"
		"call output_leds  \n\t"
		"cmp dh,0xff \n\t"
		"jne .3b \n\t"
		"call turnoff_leds  \n\t"
		"ret    \n\t"


		"output_leds: \n\t"
		"ROR dx,5  \n\t"
		"mov [0xb0000c00], dx  \n\t"
		"ROL dx,5  \n\t"
		"call delay \n\t"
		"ret \n\t"

		//turns off LEDs
		"turnoff_leds: \n\t"
		"mov dx,0x0000  \n\t"
		"mov [0xb0000c00], dx  \n\t"
		"call delay \n\t"
		"ret \n\t"

		//pattern two
		"pat2: \n\t"
		"mov edx, 0  \n\t"
		"mov dh, 0b10000000 \n\t"
		".2b: \n\t"
		"call output_leds  \n\t"
		"ror dh, 1 \n\t"
		"cmp dh, 0b00000001 \n\t"
		"jne .2b \n\t"

		".LEFT: \n\t"
		"call output_leds  \n\t"
		"rol dh,0x1 \n\t"
		"cmp dh,0b10000000 \n\t"
		"jne .LEFT \n\t"
		"call output_leds  \n\t"
		"call turnoff_leds  \n\t"
		"ret    \n\t"

		// pattern one
		"pat1: \n\t"
		"mov edx, 0  \n\t"
		"mov dh, 0b01000010 \n\t"
		"mov ecx,0  \n\t"
		".1b: \n\t"
		"call output_leds  \n\t"
		"not dh \n\t"
		"inc ecx \n\t"
		"cmp ecx,8 \n\t"
		"jne .1b \n\t"
		"call turnoff_leds  \n\t"
		"ret    \n\t"

		//delay
		"delay: \n\t"
		"push ecx \n\t"
		"mov ecx, 3560000    \n\t"
		".DELAYLOOP:      \n\t"
		"nop      \n\t"
		"dec ecx     \n\t"
		"cmp ecx,0   \n\t"
		"jne .DELAYLOOP      \n\t"
		"pop ecx \n\t"
		"ret \n\t"


		".att_syntax \n\t");

  return 0;
}



