;;simple_2.asm

format elf64
public give_number
section '.data' writeable
  
  number_2 dq -13.539

section '.text' executable
	
give_number:
  movq xmm0, [number_2]
  ret

      


