;;cvt_2.asm

format elf64
public _start

include "func.asm"

section '.data' writeable align 16
 
 float_array dd 3.6, 6.7, 8.9, 1.1
 
section '.bss' writeable align 16
 
 buffer rb 100
 int_array rd 4

section '.text' executable align 16

_start:
   mov rax, float_array
   cvttps2dq xmm0, [rax]
   mov rax, int_array
   movupd [rax], xmm0 
 
   mov rdx, 0
   .loop:
   xor rax, rax
   mov eax, [int_array+rdx]
   mov rsi, buffer
   call number_str
   call print_str
   call new_line
   add rdx, 4
   cmp rdx, 16
   je .exit
   jmp .loop
    
 .exit: 
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
