	;; pids.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar

	include "func.asm"

	section '.data' writable
	getpid db "pid: %jd", 0xa, 0
	getppid db "ppid: %ld", 0xa, 0
	getuid db "uid: %jd", 0xa, 0
	geteuid db "euid: %jd", 0xa, 0
	getgid db "gid: %jd", 0xa, 0
	getegid db "egid: %jd", 0xa, 0

	section '.text' executable
	
_start:
	;; Получаем и печатаем pid
	mov rax, 39
	syscall
	mov rdi, getpid
	mov rsi, rax
	call printf

	;; Получаем и печатаем ppid
	mov rax, 110
	syscall
	mov rdi, getppid
	mov rsi, rax
	call printf

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
