;;open_sock_2.asm

format elf64
public _start
include 'func.asm'

section '.bss' writable
	
	buffer rb 100
	
section '.text' executable
	
_start:

    ;;Создаем сокет
    mov rdi, 2 ;AF_INET - IP v4 
    mov rsi, 1 ;SOCK_STREAM
    mov rdx, 6 ;TCP
    mov rax, 41
    syscall
    
    ;;Сохраняем дескриптор сокета
    mov r9, rax
    
    mov rsi, buffer
    call number_str
    call print_str
    call new_line
    
    ;;Дублируем сокет
    mov rdi, r9
    mov rax, 32
    syscall
    
    ;;Сохраняем второй дескриптор сокета
    mov r10, rax
    
    mov rsi, buffer
    call number_str
    call print_str
    call new_line
    
    ;;Изменяем права доступа к сокету
    mov rdi, r9
    mov rsi, 0 ;;Запрет на чтение
    mov rax, 48
    syscall
    
    mov rdi, r10
    mov rsi, 1 ;;Запрет на запись
    mov rax, 48
    syscall 
    
    
    ;;Закрываем сокет
    
    mov rdi, r9
    mov rax, 3
    syscall
    
    mov rdi, r10
    mov rax, 3
    syscall
    
    call exit
    
   
    
    
    
     
