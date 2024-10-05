format elf64
public _start

include 'func.asm'

section '.text' executable
_start:
  pop rcx 
  cmp rcx, 3 
  jl .l1 

  mov rdi,[rsp+8] 
  mov rsi, [rsp+16] 
  call str_number
  mov rsi, rax
  mov rax, 90 
  syscall 
  
;В случае неуспеха в rax возвращается -1, иначе 0
  mov rdi, rax
  mov rax, 0x3c
  syscall

.l1:
  mov rax, 0x3c
  mov rdi, -1
  syscall
