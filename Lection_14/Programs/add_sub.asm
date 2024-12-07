;;add_sub.asm

format elf64
public _start

extrn printf
extrn atof


section '.data' writable

  sum db "%f + %f = %f", 0xa, 0
  difference db "%f - %f = %f", 0xa, 0
  prod db "%f * %f = %f", 0xa, 0
  division db "%f / %f = %f", 0xa, 0

section '.bss' writable

  operator_1 rq 1
  operator_2 rq 1
  
  result rq 1
  
section '.text' executable
	
_start:

  ;;Читаем параметры командной строки, преобразуем из в вещественные числа, сохраняем в памяти
  mov rdi, [rsp + 16]
  mov rax, 0
  call atof
  movq [operator_1], xmm0 
  
  mov rdi, [rsp + 24]
  mov rax, 0
  call atof
  movq [operator_2], xmm0 
  
  ;;Загружаем данные в стековые регистры, выполняем сложение
  ffree st0 
  ffree st1
  fld [operator_1] 
  fld [operator_2]
  fadd st0, st1
  fstp [result]
  
  ;;Выводим результат суммы
  movq xmm0, [operator_1] 
  movq xmm1, [operator_2]
  movq xmm2, [result]
  mov rax, 3  
  mov rdi, sum
  call printf
  
  ;;Загружаем данные в стековые регистры, выполняем умножение
  ffree st0 
  ffree st1
  fld [operator_1] 
  fld [operator_2]
  fmul st0, st1
  fstp [result]
  
  ;;Выводим результат умножения
  movq xmm0, [operator_1] 
  movq xmm1, [operator_2]
  movq xmm2, [result]
  mov rax, 3  
  mov rdi, prod
  call printf
  
  ;;Загружаем данные в стековые регистры, выполняем вычитание
  ffree st0 
  ffree st1
  fld [operator_2] 
  fld [operator_1]
  fsub st0, st1
  fstp [result]
  
  ;;Выводим результат вычитания
  movq xmm0, [operator_1] 
  movq xmm1, [operator_2]
  movq xmm2, [result]
  mov rax, 3  
  mov rdi, difference
  call printf
  
  ;;Загружаем данные в стековые регистры, выполняем деление
  ffree st0 
  ffree st1
  fld [operator_2] 
  fld [operator_1]
  fdiv st0, st1
  fstp [result]
  
  ;;Выводим результат деления
  movq xmm0, [operator_1] 
  movq xmm1, [operator_2]
  movq xmm2, [result]
  mov rax, 3  
  mov rdi, division
  call printf
  
  mov rax, 60
  mov rdi, 0
  syscall

  

      


