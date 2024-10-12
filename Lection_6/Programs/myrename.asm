	format elf64

	public _start

	include 'func.asm'

	section '.data' writable
	msg db 'Error',0x0a,0

	section '.text' executable

_start:
	pop rcx
	cmp rcx, 3
	jl .l1	
	mov rax, 82
	mov rdi, [rsp +8]
	mov rsi, [rsp+16]
	syscall

	cmp rax, 0
	je .l1

	mov rsi,msg
	call print_str

.l1:
   call exit
	
