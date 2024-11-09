	;; execve.asm
	
	format elf64

	public _start

	include 'func.asm'

	section '.bss' writable
	buffer dq 2

	section '.text' executable
	
_start:
	mov rcx, [rsp]
	cmp rcx, 1
	je ext
	cmp rcx, 2
	je n1
	cmp rcx, 3
	je n2
	jmp ext
n1:	
	mov rax, 59
	mov rdi, [rsp+16]
	syscall
n2:
	mov rdi, [rsp+16]
	mov [buffer], rdi
	mov rax, [rsp+24]
	mov [buffer+8],rax
	mov rsi, buffer
	mov rax, 59
	syscall
ext:
	call exit
