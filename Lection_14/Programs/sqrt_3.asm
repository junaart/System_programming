;;sqrt_3.asm

format elf64
public _start

extrn printf
extrn atof


section '.data' writable

  output db "%f", 0xa, 0

section '.bss' writable

  number rq 1
  buffer rb 100

  
section '.text' executable
	
_start:
  mov rdi, [rsp + 16]
  mov rax, 0
  call atof
  
  movq [number], xmm0 
  ffree st0 
  fld [number] 
  fsqrt
  fstp [number] 
  
  movq xmm0, [number] 
  mov rax, 1  
  mov rdi, output
  call printf
  
  mov rax, 60
  mov rdi, 0
  syscall

  

      


