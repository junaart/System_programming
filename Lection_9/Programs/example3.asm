	format elf64

	public main

	extrn printf
	extrn atoi

	section '.data' writable

	msg db "%d+%d=%d", 0xa, 0

	
main:
	sub rsp,8 		;выравниваем стек по границе 16 байт

	mov r12, [rsi+8]		;сохраняем адрес первого параметра
	mov r13, [rsi+16]		;сохраняем адрес второго параметра
	mov rdi, r12		;превращает первый параметр в число
	call atoi
	mov r12, rax		;сохраняем первый параметр
	mov rdi, r13		;превращаем второй параметр в число
	call atoi
	mov r13, rax		;сохраняем второй параметр
	mov rsi, r12		;готовим параметры для printf
	mov rdx, r13		;готовим параметры для printf
	add r12, r13 		;выполняем суммирование
	mov rcx, r12
	mov rdi, msg 		;готовим параметры для printf
	call printf 		;вызываем printf
	add rsp, 8		;возвращаем значение указателя стека
	ret
