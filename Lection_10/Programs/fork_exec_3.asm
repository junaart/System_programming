	;; fork_exec_3.asm
	
	format elf64

	public _start


	include "func.asm"

	section '.data' writable
	
	msg1 db "Enter the name of program", 0xa, 0
	msg2 db "The child process has terminated", 0xa, 0
	
	section '.bss' writable

	buffer rb 200
	status rd 1
	pid rq 1
	
	section '.text' executable
	
_start:	
        mov rsi, msg1
        call print_str
        call new_line 	

	mov rsi, buffer
	call input_keyboard

	mov rax, 57
	syscall
	cmp rax, 0
	jne wwait
	mov rsi, 0
	mov rdi, buffer
	mov rax, 59
	syscall
	call exit
	
   wwait:
        mov [pid], rax
        ;;mov rcx, 1000000000
        ;;mm:
        ;;nop
        ;;loop mm
        mov rdi, [pid]
        mov rsi, status
        mov rdx, 1
        mov r10, 0
        mov rax, 61
        syscall
        
        mov rsi, buffer
        xor rax, rax
        mov eax, [status]
        call number_str
        call print_str
        call new_line
  
        mov rsi, msg2
        call print_str
        call exit
