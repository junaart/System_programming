;;sem.asm
	
format elf64
public _start
include 'func.asm'

section '.data' writable
   
   val dq 1
   s1 db '1234', 0xa, 0
   
   sm1 dw 0, -1, 4096 
   sm2 dw 0, 1, 4096   
	
	
section '.bss' writable
	
	buffer rb 100
	
	ids  rq 1
	
	place rb 1
	
section '.text' executable
	
_start:

    ;;Создаем семафор
    mov rdi, 0
    mov rsi, 1
    mov rdx, 438 ;;0o666
    or rdx, 512
    mov rax, 64
    syscall
    
    mov [ids], rax
    
    ;;Переводим семафор в состояние готовности
    mov rdi, [ids] ;дескриптор семафора
    mov rsi, 0     ;индекс в массиве
    mov rdx, 16    ;выполняемая команда
    mov r10, val   ;начальное значение
    mov rax, 66
    syscall
    
    ;;Создаем дочерний процесс
    mov rax, 57
    syscall
    
    cmp rax, 0
    jne .parent
    
    mov al, 'b'
    mov [place], al
    jmp .cont
    
    .parent:
    mov al, 'a'
    mov [place], al
    
    
.cont:
    mov r9, 5
    .loop:
    ;;Запираем семафор
    mov rdi, [ids]
    mov rsi, sm1
    mov rdx,0
    mov rax, 65
    syscall
    
    mov al, [place]
    mov [buffer], al
    mov rsi, buffer
    call print_str
    
    ;;Открываем семафор
    mov rdi, [ids]
    mov rsi, sm2
    mov rdx,0
    mov rax, 65
    syscall
    
    call input_keyboard
    
    dec r9
    cmp r9, 0
    jne .loop
    call exit
    

    

    
    
    
    
    
     
