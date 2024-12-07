;;sqrt.asm

format elf64
public sqrt

section '.bss' writable

  input_number rq 1

section '.text' executable
	
sqrt:
  
  movq [input_number], xmm0 ;Сохраняем значение входного параметра в памяти
  ffree st0 ;Помечаем вершину стека свободной
  fld [input_number] ;загружаем в вершину стека входное значение
  fsqrt  ;извлекаем квадратный корень
  fstp [input_number] ;сохраняем полученое значение с вершины стека в памяти
  
  movq xmm0, [input_number] ;загружаем регистр xmm0 для возврата значения
  mov rax, 1  ;указываем количество исползуемых параметров xmm
  ret 
  
  

      


