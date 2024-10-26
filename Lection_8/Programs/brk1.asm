	format elf64
	public _start
	include 'func.asm'

	section '.bss' writable
	
	buffer_begin rq 1
	buffer_end rq 1
	buffer rb 100

	section '.data' writable
	push_word db "push", 0
	pop_word db "pop", 0
	end_word db "exit",0
	msg_error db 'kernel can not get memory',0xa,0
	msg_input db 'Enter value: ',0
	msg_output db 'Top stack is ',0
	msg_begin db 'Enter command: ',0

	section '.text' executable
	
_start:
	;; Получаем начальное значение адреса кучи
	xor rdi,rdi
	mov rax, 12
	syscall
	cmp rax, 0
	jl error

	mov [buffer_begin], rax
	mov [buffer_end], rax
	
loop_main:
	mov rsi, msg_begin
	call print_str
loop_other:	
	mov rsi, buffer
	call input_keyboard
	mov rdi, push_word
	call equal_string
	cmp rax,1
	je push_action
	mov rdi, pop_word
	call equal_string
	cmp rax,1
	je pop_action
	mov rdi, end_word
	call equal_string
	cmp rax,1
	je end_action
	jmp loop_other

pop_action:
	call new_line
	mov rax, [buffer_begin]
	cmp rax, [buffer_end]
	je loop_main
	mov rsi, msg_output
	call print_str
	mov rdi, 1 
	mov rsi, [buffer_end]
	mov rdx,1
	mov rax, 1
	syscall
	call new_line

	mov rdi, [buffer_end]
	
	sub rdi, 1
	mov rax, 12
	syscall
        cmp rax, 0
	jl error
	mov [buffer_end], rax
	jmp loop_main
	
push_action:
	call new_line
	mov rdi, [buffer_end]
	add rdi, 1
	mov rax, 12
	syscall
	cmp rax, 0
	jl error
	mov rsi, msg_input
	call print_str
	mov [buffer_end], rax
	mov rdi, 0
	mov rsi, [buffer_end]
	mov rdx,1
	mov rax, 0
	syscall
	jmp loop_main
	
end_action:	
	call exit

error:
	mov rsi, msg_error
	call print_str
	call exit

;;; Программа сравнивает строку по адресу rsi
;;; со строкой по адресу rdi
;;; Если они равны, то rax = 1
;;; Если не равны, то rax = 0
;;; input: rsi, rdi - addresses of strings
;;; output rax = 1|0
equal_string:
	mov rax, rsi
	call len_str
	mov r8,rax
	mov rax, rdi
	call len_str
	mov r9,rax
	cmp r8,r9
	jne l1
	xor rcx, rcx
	xor rax,rax
	inc rax
	xor rdx, rdx
pr:
	mov dl, [rsi+rcx]
	cmp dl, [rdi+rcx]
	jne l1
	inc rcx
	cmp rcx, r8
	jle pr
	ret
l1:
	mov rax, 0
	ret
