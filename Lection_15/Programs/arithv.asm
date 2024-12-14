;;arithv.asm

format elf64
public _start

include "func.asm"
extrn printf

section '.data' writeable 
 
 array_one dd 1, 2, 3, 15
 array_two dd 4, 5, 2, 9
 prt db "%d, %d, %d, %d", 0xa, 0
 
section '.text' executable

_start:

  ;;Загружаем области
  mov rax, array_one
  movups xmm0, [rax]
  mov rax, array_two
  movups xmm1, [rax]
  
  ;;Векторне сложение
  paddd xmm0, xmm1
  
  ;;Извлекаем данные, печатаем результат
  movd esi, xmm0
  psrldq xmm0, 4  ; сдвиг вправо в XMM0 для получения следующего числа
  movd edx, xmm0
  psrldq xmm0, 4
  movd ecx, xmm0
  psrldq xmm0, 4
  movd r8d, xmm0
  mov rdi, prt
  call printf
  
  ;;Загружаем области
  mov rax, array_one
  movups xmm0, [rax]
  mov rax, array_two
  movups xmm1, [rax]
  
  ;;Векторное вычитание
  psubd xmm0, xmm1
  
  ;;Извлекаем данные, печатаем результат
  movd esi, xmm0
  psrldq xmm0, 4 
  movd edx, xmm0
  psrldq xmm0, 4
  movd ecx, xmm0
  psrldq xmm0, 4
  movd r8d, xmm0
  mov rdi, prt
  call printf
  
  ;;Загружаем области
  mov rax, array_one
  movups xmm0, [rax]
  mov rax, array_two
  movups xmm1, [rax]
  
  ;;Векторное умножение
  pmulld xmm0, xmm1
  
  ;;Извлекаем данные, печатаем результат
  movd esi, xmm0
  psrldq xmm0, 4 
  movd edx, xmm0
  psrldq xmm0, 4
  movd ecx, xmm0
  psrldq xmm0, 4
  movd r8d, xmm0
  mov rdi, prt
  call printf
  
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
