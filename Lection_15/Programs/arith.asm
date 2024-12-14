;;arith.asm

format elf64
public _start

extrn printf
extrn scanf

section '.data' writeable 
 
 scf db "%lf", 0
 prt db "%.16f", 0xa, 0
 
section '.bss' writeable 
 
 number_1 rq 1
 number_2 rq 1

section '.text' executable

_start:

  ;;Читаем данные с клавиатуры
  mov rax, 1
  mov rdi, scf
  mov rsi, number_1
  movsd xmm0, [rsi]
  call scanf
  
  mov rax, 1
  mov rdi, scf
  mov rsi, number_2
  movsd xmm0, [rsi]
  call scanf
  
  ;Извлекаем квадратный корень из первого числа ии выводим результат
  sqrtsd xmm1, [number_1]
  
  movsd xmm0, xmm1
  mov rax, 1
  mov rdi, prt
  call printf
  
  ;Складываем числа
  movsd xmm10, [number_1]
  addsd xmm10, [number_2] 
  
  ;Вычитаем числа
  movsd xmm11, [number_1]
  subsd xmm11, [number_2] 
  
  ;Умножаем числа
  movsd xmm12, [number_1]
  mulsd xmm12, [number_2] 
  
  ;Делим числа
  movsd xmm13, [number_1]
  divsd xmm13, [number_2] 
  
  ;Находим минимум
  movsd xmm14, [number_1]
  minsd xmm14, [number_2] 
  
  ;Находим максимум
  movsd xmm15, [number_1]
  maxsd xmm15, [number_2] 
  
  ;Печатаем результаты
  movsd xmm0, xmm10
  mov rax, 1
  mov rdi, prt
  call printf
  
  movsd xmm0, xmm11
  mov rax, 1
  mov rdi, prt
  call printf
  
  movsd xmm0, xmm12
  mov rax, 1
  mov rdi, prt
  call printf
  
  movsd xmm0, xmm13
  mov rax, 1
  mov rdi, prt
  call printf
  
  movsd xmm0, xmm14
  mov rax, 1
  mov rdi, prt
  call printf
  
  movsd xmm0, xmm15
  mov rax, 1
  mov rdi, prt
  call printf
 
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
