format elf64
public _start



include 'func.asm'

section '.bss' writable
  
  buffer rb 100

_start:
  pop rcx 
  cmp rcx, 1 
  je .l1 

  mov rdi,[rsp+8] 
  mov rax, 2 
  mov rsi, 0o 
  syscall 
  cmp rax, 0 
  jl .l1 
  
  mov r8, rax
  
  mov rax, 8
  mov rdi, r8
  mov rsi, 0
  mov rdx, 2
  syscall
  
  mov rsi, buffer
  call number_str
  call print_str
  call new_line
  
  mov rdi, r8
  mov rax, 3
  syscall

.l1:
  call exit
