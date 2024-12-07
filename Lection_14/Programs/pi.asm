;;pi.asm

format elf64
public _start

extrn printf

section '.data' writeable

 output db "%f", 0xa, 0
 
section '.bss' writeable

  pi rq 1

section '.text' executable
	
_start:
  
  FINIT  ;;инициализируем мат. сопроцессор
  FLDPI  ;;загружаем pi в st0
  FSTP [pi] ;;выгружаем значение в ячейку памяти
  
  movq xmm0, [pi]
  mov rax, 1
  mov rdi, output
  call printf
  
  mov rax, 60
  mov rdi, 0
  syscall

      


