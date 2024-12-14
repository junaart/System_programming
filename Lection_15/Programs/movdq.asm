;;movdq

format elf64
public _start

include "func.asm"
extrn printf

section '.data' writeable
 
 a dd 0xffffffff ;32-битное число
 b dq 0xffffffffffffffff ;64-битное число
 c dq 3.141592653589793 ;double
 prt db "%.15f", 0xa, 0
 
section '.bss' writeable
 
 buffer rb 100 
 resd rd 1
 resq rq 1

section '.text' executable

_start:

  ;;загружаем в xmm числа разной разрядности
  movd xmm0, [a]   
  movq xmm15, [b]
  movq xmm10, [c]
  
  ;;перегружаем в память числа разной разрядности  
  movd [resd], xmm0
  movq [resq], xmm15
  
  xor rax, rax
  mov eax, [resd]  
  
  
  ;;Печатаем результат
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  xor rax, rax
  mov rax, [resq]  
  
  
  ;;Печатаем результат
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  ;;Печатаем результат
  movq xmm0, xmm10
  mov rax, 1
  mov rdi, prt 
  call printf
  
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
      


