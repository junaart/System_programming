;;cmp.asm

format elf64
public _start

extrn printf

section '.data' writeable 
 
 a dq 3.14
 b dq 3.14
 c dq 3.1
 
 prt_1 db "Equal", 0xa, 0
 prt_2 db "No Equal", 0xa, 0
 
section '.text' executable

_start:

  ;;Загружаем области
  movsd xmm0, [a]
  movsd xmm1, [b]
  movsd xmm2, [c]
  
  ;;Сравниваем два числа
  cmpeqsd xmm0, xmm1
  
  ;Загружаем результат сравнения в регистр rax
  movq rax, xmm0
  
  ;;Если rax = -1, условие верно
  cmp rax, -1
  jne .ne
  
  mov rdi, prt_1
  call printf
  jmp .next
  .ne:
  mov rdi, prt_2
  call printf

.next:
  movsd xmm0, [a]
  cmpeqsd xmm0, xmm2
  
  movq rax, xmm0
  
  cmp rax, -1
  jne .nne
  
  mov rdi, prt_1
  call printf
  jmp .exit
  .nne:
  mov rdi, prt_2
  call printf
.exit: 
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
