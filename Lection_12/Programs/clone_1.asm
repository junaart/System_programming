;;clone_1.asm
format elf64
public _start
include 'func.asm'

THREAD_FLAGS=2147585792

section '.data' writable
	
place db 0
	
section '.bss' writable
	
stack_1 rq 4096 
buffer rb 100
	
section '.text' executable
	
_start:

   ;;Печатаем PID родительского процесса
   mov rax, 39
   syscall
   mov rsi, buffer
   call number_str
   call print_str
   call new_line
   
   ;; Создаем новый тред
   
   ;;Устанавливаем флаги
   mov rdi, THREAD_FLAGS
   
   ;;Инициализируем указатель стека
   mov rsi, 4096
   add rsi, stack_1
   
   mov rax, 56
   syscall
   
   ;;Проверяем это дочерний процесс, или родитель
   cmp rax,0
   je new_thread
   
   
   ;;Продолжаем работу в родительском процессе 
   
   ;;Печатаем PID дочернего процесса
   mov rsi, buffer
   call number_str
   call print_str
   call new_line
   
   call input_keyboard
   
   ;;Печатаем значение в ячейке памяти place
   xor rax, rax
   mov al, [place]
   mov rsi, buffer
   call number_str
   call print_str
   call new_line
   call exit
   
;;В треде увеличивается на единицу значение в ячейке памяти place	
new_thread:
  xor rax, rax
   mov al, [place]
   inc rax
   mov [place], al
   call exit
  
  
	
