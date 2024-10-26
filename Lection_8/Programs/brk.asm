	format elf64
	public _start
	include 'func.asm'

	section '.bss' writable
	
	buffer_begin rq 1
	buffer_end rq 1
	buffer rb 100

	section '.data' writable
	msg_error db 'kernel can not get memory',0xa,0

	section '.text' executable
	
_start:
	;; Считываем количество параметров командной строки
	pop rcx
	cmp rcx, 2
	jne error

	;; Преобразуем значение из командной строки в число
	mov rsi, [rsp+8]
	call str_number
	mov r8,rax

	;; Получаем начальное значение адреса кучи
	xor rdi,rdi
	mov rax, 12
	syscall
	cmp rax, 0
	jl error
	
	mov [buffer_begin], rax
	

	mov rsi, buffer
	call number_str
	call print_str
	call new_line

	;; Увеличиваем размер кучи на количество, переданное параметром ком. строки
	mov rdi, [buffer_begin]
	
	add rdi, r8
	mov rax, 12
	syscall
	cmp rax, 0
	jl error
	
	mov [buffer_end], rax

	mov rsi, buffer
	call number_str
	call print_str
	call new_line
	
	call exit
error:
	mov rsi, msg_error
	call print_str
	call exit
