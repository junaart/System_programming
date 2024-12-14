;;mmx.asm

format elf64
public _start

include "func.asm"

section '.data' writeable
 
 number_1 dq 0x35182cf4997c90fe
 number_2 dq 0x0a0a0a0a0a0a0a0a
 
section '.bss' writeable
 
 buffer rb 100 
 res rq 1

section '.text' executable
	
_start:
  emms
  movq mm0, [number_1]
  movq mm1, [number_2]
  
  paddb mm0, mm1
  
  movq [res], mm0
  
  mov rax, [res]
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  mov rax, 60
  mov rdi, 0
  syscall

      


