	format elf64
	public _start
	include 'func.asm'

	volume = 10000
	section '.text' executable
	
_start:
	;; выполняем анонимное отображение в память
	mov rdi, 0    ;начальный адрес выберет сама ОС
	mov rsi, volume ;задаем размер области памяти
	mov rdx, 0x3  ;совмещаем флаги PROT_READ | PROT_WRITE
	mov r10,0x22  ;задаем режим MAP_ANONYMOUS|MAP_PRIVATE
	mov r8, -1   ;указываем файловый дескриптор null
	mov r9, 0     ;задаем нулевое смещение
	mov rax, 9    ;номер системного вызова mmap
	syscall

	mov rsi, rax  ;Сохраняем адрес памяти анонимного отображения
	mov rax, 0
	mov rdi, 0
	mov rdx,  1000
	syscall
	xor rcx, rcx
	.loop:
	mov al, [rsi+rcx]
	inc rcx
	cmp rax, 0x0A
	jne .loop
	dec rcx
	mov byte [rsi+rcx], 0

	call new_line

	call print_str

	call new_line

	;; выполняем системный вызов munmap, освобождая память
	mov rdi, rsi
	mov rsi, volume
	mov rax, 11
	syscall

	call exit
