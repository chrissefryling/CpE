#include "qm_pin_functions.h"

char msg1[18] = "Button One Pressed";
char msg2[18] = "Button Two Pressed";
char msg3[14] = "Program Exited";

int main(void)
{
	/* Set the GPIO pin muxing. */
	__asm__(".intel_syntax noprefix\n\t"



			//prepare muxing
			"mov edx, 0 \n\t" //MUX function 0 (GPIO)
			"mov eax, 8 \n\t" //IO PIN number
			"call qm_pmux_select \n\t"
			"mov edx, 0 \n\t" //MUX function 0 (GPIO)
			"mov eax, 9 \n\t" //IO PIN number
			"call qm_pmux_select \n\t"
			"mov edx, 0 \n\t" //MUX function 0 (GPIO)
			"mov eax, 10 \n\t" //IO PIN number
			"call qm_pmux_select \n\t"


			//Set Line direction as OUTPUTS
			"mov dh, 0x00		\n\t" 	//set lines 8-15 as ins with 0's
			//"mov ch, 0x1C		\n\t"
			"mov [0x0B0000C04], edx 	\n\t" 	//set mem-mapped addr to set line dir.
			"mov edx, 0 \n\t"
			"mov ax, 0x0000 \n\t"
			// Start Loop
		//Poll
			".TOP: \n\t"
			"mov eax, [0x0B0000C50] \n\t"
			"and ax, 0x0700 \n\t"
			"cmp ax, 0x0600 \n\t"
			"je .but1 \n\t"
			"cmp ax, 0x0300 \n\t"
			"je .but2 \n\t"
			"cmp ax, 0x0500 \n\t"
			"je .but3 \n\t"
			"jmp .TOP \n\t"
		// Button 1
			".but1: \n\t"
			"lea edi, msg1 \n\t"
			"call print_string \n\t"
			"jmp .TOP \n\t"
		// Button 2
			".but2: \n\t"
			"lea edi, msg2 \n\t"
			"call print_string \n\t"
			"jmp .TOP \n\t"
		//Button 3
			".but3: \n\t"
			"lea edi, msg3 \n\t"
			"call print_string \n\t"
			"jmp .TOP \n\t"

			//"je .TOP \n\t"



//			"mov edx, 0 \n\t"
	//		"mov dh, 0x00			\n\t" //lines 8-15 to ?’s to turn on LEDs

		//	".TOP: \n\t"


			//Print Outputs
			"print_string: 			\n\t"
			"push eax				\n\t" //now I can overwrite eax without worry
			"push edx 				\n\t" //now I can overwrite edx without worry
			".print_loop: 			\n\t"
			"mov dl,[edi]			\n\t"
			"cmp dl,'$'				\n\t"
			"je .end_print_sub 		\n\t"
			"mov eax,0 				\n\t" //sometimes uart_write doesn't work w/o eax=0
			"call qm_uart_write 	\n\t"
			"inc edi 				\n\t" //increment index to next mem addr
			"jmp .print_loop		\n\t"
			".end_print_sub: 		\n\t"
			"mov dl,0x0a			\n\t" //new line character
			"call qm_uart_write 	\n\t"
			//pop regs in LIFO order
			"pop edx 				\n\t" //restore edx before sub call
			"pop eax 				\n\t" //restore eax before sub call
			"ret					\n\t"

			".att_syntax \n\t");
}

