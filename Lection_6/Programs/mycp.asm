format elf64
public _start

include 'func.asm'

section '.bss' writable

  buffer rb 100

section '.text' executable

_start:
  ;Считываем количество пааметров командной строки
   pop rcx
   cmp rcx, 3
   jl .l1

   ;открываем файл, который будем читать
   mov rdi,[rsp+8]
   mov rax, 2
   mov rsi, 0o
   syscall
   cmp rax, 0
   jl .l1
   ;Сохраняем дескриптор
   mov r8, rax

   ;открываем файл, в который будем копировать
   mov rdi,[rsp+16]
   mov rax, 2
   mov rsi, 577
   mov rdx, 777o
   syscall
   cmp rax, 0
   jl .l1
   ;Сохраняем дескриптор
   mov r9, rax

    ;Признак окончания чтения
   xor r10, r10
   .loop:
     mov rax, 0 ;номер системного вызова чтения
     mov rdi, r8
     mov rsi, buffer
     mov rdx, 100
     syscall
     cmp rax, 0
     jne .next
     inc r10
     .next:
       mov rdi, r9
       mov rdx, rax
       mov rax, 1
       mov rsi, buffer
       syscall
       cmp r10,0
       je .loop

   mov rdi, r8
   mov rax, 3
   syscall

   mov rdi, r9
   mov rax, 3
   syscall

.l1:
   call exit
