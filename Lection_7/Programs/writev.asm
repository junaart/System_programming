;;Пример использования фрагментированной записи
format elf64
public _start

include 'func.asm'

section '.data' writable

name_file db "test",0

section '.bss' writable

buffer1 rb 1000
buffer2 rb 1000
buffer3 rb 1000

Struc iovec
{
  .field1 rq 1
  .count1 rq 1
  .field2 rq 1
  .count2 rq 1
  .field3 rq 1
  .count3 rq 1
}


mystr iovec

section '.text' executable

_start:

   mov rax, 2
   mov rdi, name_file
   mov rsi, 1101o
   mov rdx, 777o
   syscall
   mov r9, rax

   mov rsi, buffer1
   call input_keyboard

   mov rsi, buffer2
   call input_keyboard

   mov rsi, buffer3
   call input_keyboard

   mov [mystr.field1], buffer1
   mov rax, buffer1
   call len_str
   mov [mystr.count1], rax

   mov [mystr.field2], buffer2
   mov rax, buffer2
   call len_str
   mov [mystr.count2], rax

   mov [mystr.field3], buffer3
   mov rax, buffer3
   call len_str
   mov [mystr.count3], rax

    mov rdi, r9
    mov rsi, mystr
    mov rdx,3
    mov rax,20
    syscall

   ;;Системный вызов close
   mov rdi, r9
   mov rax, 3
   syscall
   call exit
