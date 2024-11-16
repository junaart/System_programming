	;; get_set_uid.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar

	include "func.asm"

	section '.data' writable
	
	getuid db "uid: %jd", 0xa, 0
	geteuid db "euid: %jd", 0xa, 0
	msg_1 db "change uid = %d", 0xa, 0

	section '.text' executable
	
_start:
	;; Получаем и печатаем uid
	mov rax, 102
	syscall
	mov rdi, getuid
	mov rsi, rax
	call printf

	;; Получаем и печатаем euid
	mov rax, 107
	syscall
	mov rdi, geteuid
	mov rsi, rax
	call printf

	mov rsi, [rsp+16]
	call str_number
	mov rsi, rax
	mov r12, rax
	mov rdi, msg_1
	call printf
	
	
	
	;; Изменяем uid
	mov rdi, r12
	mov rax, 105
	syscall

	
	;; Получаем и печатаем uid
	mov rax, 102
	syscall
	mov rdi, getuid
	mov rsi, rax
	call printf

	;; Получаем и печатаем euid
	mov rax, 107
	syscall
	mov rdi, geteuid
	mov rsi, rax
	call printf

	
	;; Ожидаем ввода любого символа и заканчиваем работу
	call getchar
	call exit
