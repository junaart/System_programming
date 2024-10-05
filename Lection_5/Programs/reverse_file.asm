format elf64
public _start

include 'func.asm'

section '.bss' writable
  
  buffer rb 2

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

  mov r10, rax ;сохраняем длину файла

  
.loop:
   cmp r10, 0
   jl .l2
   mov rax, 0
   mov rdi, r8
   mov rsi, buffer
   mov rdx, 1 
   syscall 
   mov [buffer+1], 0
   call print_str
   dec r10
   mov rax, 8
   mov rdi, r8
   mov rsi, r10
   mov rdx, 0
   syscall
   jmp .loop
   
.l2:
  call new_line
  mov rdi, r8
  mov rax, 3
  syscall

.l1:
  call exit
