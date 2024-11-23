;;clone_3.asm
	
	format elf64
	public _start
	include 'func.asm'
	
	THREAD_FLAGS=2147585792
	MAP_GROWSDOWN = 0x0100
 	MAP_ANONYMOUS = 0x0020
 	MAP_PRIVATE = 0x0002
 	PROT_READ = 0x1
 	PROT_WRITE = 0x2
 	PROT_EXEC = 0x4
 	STACK_SIZE = 4096
 	


	section '.data' writable
	
	f  db "/dev/urandom",0
	
	TTL db 10
	
	msg db "Hello, world",0
	
	section '.bss' writable
	
	buffer db 100
	
	section '.text' executable
	
_start:

   .loop:
   
   ;;Запускаем тред
   
   call stack_create
   add rax, STACK_SIZE
   mov rsi, rax
   mov rdi, THREAD_FLAGS
   mov rax, 56
   syscall
   cmp rax,0
   je thread
   
   ;;Печатаем PID родительского процесса
   mov rsi, buffer
   call number_str
   call print_str
   call new_line
   
   ;;Проверяем условие выхода
   xor rax,rax
   mov al, [TTL]
   dec rax
   mov [TTL], al
   cmp rax,0
   jg .loop
  
   call exit
   

  
 ;;Выделяем стек с использованием анонимного отображения в память
 stack_create:
    mov rdi, 0
    mov rsi, STACK_SIZE
    mov rdx, 0x3
    mov r10, 0x122
    mov r9, 0 
    mov rax, 9
    syscall
    ret
    
;;Выполнение треда
thread:
  mov rsi, msg
  call print_str
  call new_line
  call exit  
	
