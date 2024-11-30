;;open_sock.asm

;;SOCK_STREAM
;;
	
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
    
    mov rsi, buffer
    call number_str
    call print_str
    call new_line
    
    call exit
    
   
    
    
    
     
