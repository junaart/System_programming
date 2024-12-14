;;cvt.asm

format elf64
public _start

include "func.asm"

section '.data' writeable
 
 number_1 dq 3.14
 number_2 dq 9.5
 
section '.bss' writeable
 
 buffer rb 100
 state dd 1

section '.text' executable

_start:

  ;;Загружаем вещественное число из памяти number_1 и преобразуем его в целое с округлением до ближайшего
  movsd xmm0, [number_1]
  cvtsd2si rax, xmm0
  
  ;;Печатаем результат
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  ;;Загружаем вещественное число из памяти number_2 и преобразуем его в целое с округлением до ближайшего
  movsd xmm1, [number_2]
  cvtsd2si rax, xmm1
 
  ;;Печатаем результат 
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  ;;Меняем регистр управления, устанавливая округление до большего целого
  stmxcsr [state]       
  or [state], dword 100000000000000b
  ldmxcsr [state]
  
  movsd xmm2, [number_2]
  cvtsd2si rax, xmm2
 
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  ;;Меняем регистр управления, устанавливая округление до меньшего целого
  stmxcsr [state]       
  or [state], dword 010000000000000b
  ldmxcsr [state]
  
  movsd xmm2, [number_2]
  cvtsd2si rax, xmm2
 
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  ;;Завершаем программу
  mov rax, 60
  mov rdi, 0
  syscall
