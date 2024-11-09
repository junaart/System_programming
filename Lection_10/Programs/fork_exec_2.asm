	;; fork_exec_2.asm
	
	format elf64

	public _start


	include "func.asm"

	section '.data' writable
	
	msg db "Enter the name of program", 0xa, 0
	
	section '.bss' writable

	buffer rb 200
	
	section '.text' executable
	
_start:
	
   main_loop:
 
        mov rsi, msg
        call print_str
        call new_line 	

	mov rsi, buffer
	call input_keyboard

	mov rax, 57
	syscall
	cmp rax, 0
	jne main_loop
	mov rsi, 0
	mov rdi, buffer
	mov rax, 59
	syscall
   jmp main_loop
