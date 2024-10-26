	format elf64

	public create_array
	public free_memory

	section '.data' writable

	section '.bss' writable

	array_begin rq 1
	count rq 1

create_array:
	mov [count], rdi
	;; Получаем начальное значение адреса кучи
	xor rdi,rdi
	mov rax, 12
	syscall
	mov [array_begin], rax
	mov rdi, [array_begin]
	add rdi, [count]
	mov rax, 12
	syscall
	mov rax, array_begin
	ret

free_memory:
	xor rdi,[array_begin]
	mov rax, 12
	syscall
	ret
	
