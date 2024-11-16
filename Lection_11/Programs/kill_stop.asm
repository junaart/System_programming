	;; kill_stop.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar
	extrn usleep

	include "func.asm"
	
	section '.data' writable
	
	msg_1 db "stop", 0xa, 0
	
	msg_2 db "cont", 0xa, 0

	section '.bss' writable
	
	pid dq 1
	


	section '.text' executable
	
_start:



        mov rsi, [rsp+16]
	call str_number
	mov [pid], rax
.loop:
	mov rdi, msg_2
	call printf
	
	mov rdi, 3000000
	call usleep
	
	mov rdi, [pid]
	mov rsi, 19
	mov rax, 62
	syscall
	
	mov rdi, msg_1
	call printf
	
	mov rdi, 3000000
	call usleep
	
	mov rdi, [pid]
	mov rsi, 18
	mov rax, 62
	syscall
	
jmp .loop
	
	call exit
