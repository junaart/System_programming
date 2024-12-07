;;out_float.asm

format elf64
public _start

extrn printf

section '.data' writeable
 
 number dq -13.124

 prt db "%f", 0xa, 0

section '.text' executable
	
_start:
  mov rdi, prt ;Строка вывода для printf
  movq xmm0, [number] ;вещественные числа загружаем в регистры xmm
  mov rax, 1 ;в rax нужно указать, сколько используется регистров xmm для передачи в printf 
  call printf
  
  mov rax, 60
  mov rdi, 0
  syscall

      


