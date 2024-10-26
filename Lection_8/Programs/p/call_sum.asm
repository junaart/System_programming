	format elf64

	public _start

	extrn sum

	include "func.asm"

	section ".data" writable

	buffer dq 1
section ".text" executable
_start:
	pop rcx
	cmp rcx, 3
	jne .l1
	mov rsi, [rsp+8]
	call str_number
	mov rdi, rax
	mov rsi, [rsp+16]
	call str_number
	mov rsi, rax
	call sum
	mov rsi, buffer
	call number_str
	call print_str
	call new_line
.l1:
	call exit
