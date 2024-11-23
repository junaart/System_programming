;;ipc_2.asm
	
format elf64
public _start
include 'func.asm'

section '.data' writable
   
   msg db "Error create pipe",0xa, 0
   pipefd dq 0
   msg_parent db "Hello, my children", 0xa, 0
   len_msg dq 0
	
	
section '.bss' writable
	
	buffer db 100
	
section '.text' executable
	
_start:

    ;;Создаем неименованный канал
    mov rax, 22
    mov rdi, pipefd
    syscall
    
    cmp rax,0
    jnl .cont
    mov rsi, msg
    call print_str
    call new_line
    call exit
    
    ;;Создаем дочерний процесс
.cont: 
    mov rax, 57
    syscall
        
    cmp rax, 0
    je .children
    
    ;;закрываем канал на чтение в родительском процессе
    xor rdi, rdi
    mov edi, dword [pipefd]
    mov rax, 3
    syscall 
    
    ;;Определяем длину сообщения
    mov rax, msg_parent
    call len_str
    
    ;;Пишем в канал
    mov rdx, rax
    mov rsi, msg_parent
    xor rdi, rdi
    mov edi, dword [pipefd+4]
    mov rax, 1
    syscall
    
    mov rsi, buffer
    call input_keyboard
    
    ;;закрываем канал на запись родителю
    xor rdi, rdi
    mov edi, dword [pipefd+4]
    mov rax, 3
    syscall
    call exit
  
.children:
     ;;Закрываем канал на запись в дочернем процессе
    xor rdi, rdi
    mov edi, dword [pipefd+4]
    mov rax, 3
    syscall
    
    ;;Читаем из pipe
    xor rdi, rdi
    mov edi, dword [pipefd]
    mov rsi, buffer
    mov rdx, 100
    mov rax, 0
    syscall
    call print_str
    
    ;;закрываем канал на чтение в дочернем процессе
    xor rdi, rdi
    mov edi, dword [pipefd]
    mov rax, 3
    syscall 
    
    call exit
    
     
