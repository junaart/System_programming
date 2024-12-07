;;sqrt_2.asm

format elf64
public _start

extrn scanf
extrn printf
extrn sqrt

section '.data' writable

  input db "%lf",0 
  output db "%f", 0xa, 0

section '.bss' writable

  number rq 1
  number_2 rq 1
  
section '.text' executable
	
_start:
  
  mov rdi, input
  mov rsi, number
  movq xmm0, rsi
  mov rax, 1
  call scanf
  
  movq [number], xmm0 
  movq [number_2], xmm0
  ffree st0 
  fld [number] 
  fsqrt
  fstp [number] 
  
  movq xmm0, [number] 
  mov rax, 1  
  mov rdi, output
  call printf
  
  ;;Используем математическую библиотеку для сравнения
  movq xmm0, [number_2]
  mov rax, 1
  call sqrt
  
  mov rax, 1  
  mov rdi, output
  call printf
  
  mov rax, 60
  mov rdi, 0
  syscall

  

      


