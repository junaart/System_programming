	;; get_set_gid.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar

	include "func.asm"

	section '.data' writable
	
	getgid db "gid: %jd", 0xa, 0
	getegid db "egid: %jd", 0xa, 0
	msg db "change gid = %d", 0xa, 0

	section '.text' executable
	
_start:
	;; Получаем и печатаем gid
	mov rax, 104
	syscall
	mov rdi, getgid
	mov rsi, rax
	call printf

	;; Получаем и печатаем egid
	mov rax, 108
	syscall
	mov rdi, getegid
	mov rsi, rax
	call printf
	
	mov rsi, [rsp+16]
	call str_number
	mov rsi, rax
	mov r12, rax
	mov rdi, msg
	call printf
	
	;; Изменяем gid
	mov rax, 106
	mov rdi, r12
	syscall

	;; Получаем и печатаем gid
	mov rax, 104
	syscall
	mov rdi, getgid
	mov rsi, rax
	call printf

	;; Получаем и печатаем egid
	mov rax, 108
	syscall
	mov rdi, getegid
	mov rsi, rax
	call printf
	
	;; Ожидаем ввода любого символа и заканчиваем работу
	call getchar
	call exit
