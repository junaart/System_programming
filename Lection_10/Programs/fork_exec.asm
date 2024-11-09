	;; fork_exec.asm
	
	format elf64

	public _start
	
	include "func.asm"


	section '.data' writable
	
	b1 db "./script1.sh",0
	b2 db "./script2.sh", 0

	msg1 db "1 - script1.sh", 0xa, 0
	msg2 db "2 - script2.sh",0xa, 0
	msg3 db "3 - exit",0xa, 0
	
	section '.bss' writable
	
	buffer rd 100

	
	section '.text' executable
	
_start:
	
   main_loop:	
   
   ;;Выводим сообщения
	mov rsi, msg1
	call print_str
	call new_line
	mov rsi, msg2
	call print_str
	call new_line
	mov rsi, msg3
	call print_str
	call new_line
	
   ;;Читаем введенный символ с клавиатуры и анализиоуем ввод
	mov rsi, buffer
	call input_keyboard
	
	xor rax, rax
	mov al, byte [buffer]
	
	cmp rax, '1'
	je l1

	cmp rax, '2'
	je l2

	cmp rax, '3'
	je l3
   jmp main_loop

   l1:
     ;;Создаем fork и анализируем какой это процесс 
	mov rax, 57
	syscall
	cmp rax, 0
      ;;Если это родительский процесс, возвращаемся в главный цикл
	jne main_loop
	mov rsi, 0
      ;;Если это дочерний процесс, запускаем с помощью execve script1.sh
	mov rdi, b1
	mov rax, 59
	syscall

   l2:
     ;;Аналогично предыдущему, создаем fork и анализируем, какой это процесс
	mov rax, 57
	syscall
	cmp rax, 0
	jne main_loop
	mov rsi, 0
	mov rdi, b2
	mov rax, 59
	syscall
   l3:	
	call exit
