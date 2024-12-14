;;mova.asm

format elf64
public _start

include "func.asm"

section '.data' writeable ;align 16
 
 source db  "abcdefghijklmo", 0 
 
section '.bss' writeable ;align 16
 
 receiver rd 4

section '.text' executable

_start:

  ;;Копируем области памяти
  mov rax, source
  movaps xmm0, [rax]
  mov rax, receiver
  movaps [rax], xmm0
  
  ;;Печатаем результат
  mov rsi, receiver
  call print_str
  call new_line
   
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
      


