	;; get_set_gid.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar

	include "func.asm"

	section '.data' writable
	
	getprocess db "process_priory: %jd", 0xa, 0
	
	getpgrp db "pgrp_priory: %jd", 0xa, 0
	
	getuser db "user_priory: %jd", 0xa, 0

	msg db "change priory", 0xa, 0
	
	msg_2 db "Error set priory", 0xa, 0

	section '.text' executable
	
_start:
	;; Получаем priory_progress
	mov rax, 140
	mov rdi, 0
	mov rsi,0
	syscall
	mov rdi, getprocess
	mov rsi, rax
	call printf
	
	;; Получаем priory_pgrp
	mov rax, 140
	mov rdi, 1
	mov rsi,0
	syscall
	mov rdi, getpgrp
	mov rsi, rax
	call printf
	
	;; Получаем priory_user
	mov rax, 140
	mov rdi, 2
	mov rsi,0
	syscall
	mov rdi, getuser
	mov rsi, rax
	call printf
	
	call new_line
	
	mov rdi, msg
	call printf
	
	call new_line
	
	;; Устанавливаем priory_process
	mov rax, 141
	mov rdi, 0
	mov rsi,0
	mov rdx, 8
	syscall
	cmp rax, 0
	je pp_1
	mov rdi, msg_2
	call printf
	pp_1:
	
	;; Получаем priory
	mov rax, 140
	mov rdi, 0
	mov rsi,0
	syscall
	mov rdi, getprocess
	mov rsi, rax
	call printf
	
	;; Устанавливаем priory_pgrp
	mov rax, 141
	mov rdi, 1
	mov rsi,0
	mov rdx, 12
	syscall
	cmp rax, 0
	je pp_2
	mov rdi, msg_2
	call printf
	pp_2:
	
	;; Получаем priory
	mov rax, 140
	mov rdi, 1
	mov rsi,0
	syscall
	mov rdi, getpgrp
	mov rsi, rax
	call printf
	
	;; Устанавливаем priory_user
	mov rax, 141
	mov rdi, 2
	mov rsi,0
	mov rdx, 10
	syscall
	cmp rax, 0
	je pp_3
	mov rdi, msg_2
	call printf
	pp_3:
	
	;; Получаем priory_user
	mov rax, 140
	mov rdi, 2
	mov rsi,0
	syscall
	mov rdi, getuser
	mov rsi, rax
	call printf

	;; Ожидаем ввода любого символа и заканчиваем работу
	call getchar
	call exit
