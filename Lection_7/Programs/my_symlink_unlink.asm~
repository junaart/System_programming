format elf64

public _start

include 'func.asm'

section '.data' writable

msg db 'error', 0x0a, 0

section '.text' executable

_start:

  pop rcx

  ;;Если два параметра
  cmp rcx, 3
  jne .l1
  mov rax, [rsp+8]
  cmp byte [rax], '0'
  jne .l2
  mov rax, 87
  mov rdi, [rsp+16]
  syscall
  cmp rax, 0
  jl .l3
  jmp .l2

  ;;Если три параметра
.l1:
  cmp rcx, 4
  jne .l2
  mov rax, [rsp+8]
  cmp byte [rax], '1'
  jne .l2
  mov rax, 86
  mov rdi, [rsp+16]
  mov rsi,[rsp+24]
  syscall
  cmp rax, 0
  jl .l3
  jmp .l2
.l3:
  mov rsi,msg
  call print_str

.l2:
   call exit
   
