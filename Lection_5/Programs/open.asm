format elf64
public _start

include 'func.asm'

section '.data' writable

pathname db "my", 0
place rb 5

_start:
   ;;Системный вызов open
   mov rax, 2
   mov rdi, pathname
   mov rsi, 1101o
   mov rdx, 777o
   syscall
   
   ;Сохраняем файловый дескриптор
   push rax
   
   ;;Печатаем значение файлового дескриптора
   mov rsi, place
   call number_str
   call print_str
   call new_line
   
   pop rax
   cmp rax, 0
   jl .l1
   
   ;;Системный вызов close
   mov rdi, rax
   mov rax, 3
   syscall
   
.l1:
   call exit
