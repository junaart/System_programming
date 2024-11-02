	format elf64

	public _start

	include "func.asm"

	extrn printf

	section '.data' writable

	msg db "%d+%d=%d", 0xa, 0
	
_start:
	mov rcx, [rsp]
	cmp rcx, 3
	jne ext
	mov rsi, [rsp+16]
	call str_number
	mov r8, rax
	mov rsi, [rsp+24]
	call str_number
	mov r9, rax
	mov rsi, r8
	mov rdx, r9
	mov rcx, rsi
	add rcx, rdx
	mov rdi, msg
	call printf
ext:
	call exit
