;;ipc.asm
	
format elf64
public _start
include 'func.asm'

section '.data' writable
   
   msg_1 db "First process",0
   msg_2 db "Second process",0
   
	
	
section '.bss' writable
	
	buffer rb 100
	address rq 1
	
	
	
section '.text' executable
	
_start:
    mov rsi, msg_1
    call print_str
    call new_line
    
    ;;Первый процесс создает разделяемую память
    mov rdi, 0    ;начальный адрес выберет сама ОС
    mov rsi, 8    ;задаем размер области памяти
    mov rdx, 0x3  ;совмещаем флаги PROT_READ | PROT_WRITE
    mov r10, 0x21  ;задаем режим MAP_ANONYMOUS|MAP_SHARED
    mov r8, -1   ;указываем файловый дескриптор null
    mov r9, 0     ;задаем нулевое смещение
    mov rax, 9    ;номер системного вызова mmap
    syscall
    
    ;;Сохраняем и печатаем адрес памяти
    mov [address], rax
    mov rsi, buffer
    call number_str
    call print_str
    call new_line
    call new_line
    
    ;;Делаем fork процесса
    
    mov rax, 57
    syscall
    cmp rax, 0
    je fork_process
    
    .loop: 
    mov rax, [address]
    mov rcx, [rax]
    cmp rcx, 0
    je .loop
    
    mov rcx, [address]
    mov rax, [rcx]
    mov rsi, buffer
    call number_str
    call print_str
    call new_line
    
    ;; выполняем системный вызов munmap, освобождая память
    mov rdi, [address]
    mov rsi, 1
    mov rax, 11
    syscall
    call exit
  
  
  fork_process:
    mov rsi, msg_2
    call print_str
    call new_line
    
    mov rsi, buffer
    call input_keyboard
    call str_number
    mov [address], rax
    
    mov rcx, [rax]
    inc rcx
    mov [rax], rcx
    
    call exit
