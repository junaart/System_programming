format elf64
public _start

include 'func.asm'

section '.data' writable
a dq 12
b dq 20
minus db '-'
buffer rb 100

section '.text' executable

_start:
   mov rax, [a]
   sub rax, [b]

   ;Проверка знака
   cmp rax, 0
   jge .convert

   ;печать минуса
   mov rsi,minus
   call print_str

   ;превращение числа в rax в положительное
   neg rax ;;инструкция, которая меняет знак числа на противоположный (инвертирует биты и прибавляет 1 по правилам дополнительного кода)

.convert:
   mov rsi, buffer
   call number_str
   call print_str
   call new_line

   call exit



