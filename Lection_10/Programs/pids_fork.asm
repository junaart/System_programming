	;; pids_fork.asm
	
	format elf64

	public _start

	extrn printf
	extrn getchar

	include "func.asm"

	section '.data' writable
	getpid db "pid: %jd", 0xa, 0
	getppid db "ppid: %ld", 0xa, 0
	msg1 db "I'm the parent", 0xa, 0
	msg2 db "I'm the children",0xa, 0

	section '.bss' writable

	pr db 1
	
	section '.text' executable
	
_start:
	mov rax, 57
	syscall
	cmp rax, 0
	je l1
	mov al, 1
	mov [pr], al
	jmp lloop

l1:
	mov al, 0
	mov [pr], al
lloop:
	xor rax, rax
	mov al, [pr]
	cmp rax, 1
	je ll1
	mov rdi, msg2
	call printf
	jmp ll2
ll1:
	mov rdi, msg1
	call printf
ll2:	
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


	;; Ожидаем ввода любого символа и заканчиваем работу

	call getchar
	cmp rax, 'q'
	jne lloop
	call exit
