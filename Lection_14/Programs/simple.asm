;;simple.asm

format elf64
public _start
section '.data' writeable
  
  number_1 dd 13.539
  number_2 dq 13.539
  number_3 dt 13.539

section '.text' executable
	
_start:
  nop
  mov rax, 60
  syscall

      


