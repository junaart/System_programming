;;listen_accept_1.asm

format elf64
public _start
include 'func.asm'

section '.data' writeable
  
  msg_1 db 'Error bind', 0xa, 0
  msg_2 db 'Successfull bind', 0xa, 0
  msg_3 db 'New connection', 0xa, 0
  msg_4 db 'Successfull listen', 0xa, 0

section '.bss' writable
	
  buffer rb 100

  struc sockaddr_in
{
  .sin_family dw 2         ; AF_INET
  .sin_port dw 0x3d9     ; port 60000
  .sin_addr dd 0           ; localhost
  .sin_zero_1 dd 0
  .sin_zero_2 dd 0
}

  addrstr sockaddr_in 
  addrlen = $ - addrstr

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
    
       
    ;;Связываем сокет с адресом
    
    mov        rax, 49              ; SYS_BIND
    mov        rdi, r9              ; дескриптор сервера
    mov        rsi, addrstr        ; sockaddr_in struct
    mov        rdx, addrlen         ; length of sockaddr_in
    syscall

    ;; Проверяем успешность вызова
    cmp        rax, 0
    jl         _bind_error
    
    mov rsi, msg_2
    call print_str
    
    ;;listen
    mov rax, 50 ;sys_listen
    mov rdi, r9 ;дескриптор
    mov rsi, 3  ; количество клиентов
    syscall
    cmp rax, 0
    jl  _bind_error
    
    mov rsi, msg_4
    call print_str
    
    .main_loop:
      
      ;;accept
      mov rax, 43
      mov rdi, r9
      mov rsi, 0
      mov rdx, 0
      syscall
      
      ;;Сохраняем дескриптор сокета клиента
      mov r12, rax
      
      ;;Печатаем сообщение о подключении
      mov rsi, msg_3
      call print_str
      
      mov rax, 48
      mov rdi, r12
      mov rsi, 2
      syscall
      
      ;;Закрываем сокет
      mov rdi, r12
      mov rax, 3
      syscall
      
     jmp .main_loop
    
_bind_error:
   mov rsi, msg_1
   call print_str
   call exit
