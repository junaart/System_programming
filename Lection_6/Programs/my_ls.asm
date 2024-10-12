format elf64
public _start

include 'func.asm'

len = 1024

section '.data' writable

  DT_BLK    db " block device ",0x0a, 0                  ;(значение 6) блочное устройство.
  DT_CHR    db " symbolic device ",0x0a, 0            ;(значение 2) символьное устройство.
  DT_DIR      db " directory ",0x0a, 0                      ;(значение 4) каталог.
  DT_FIFO     db " fifo ",0x0a, 0                               ;(значение 1) именованный канал (FIFO).
  DT_LNK      db " symbolic link ",0x0a, 0               ;(значение 10) символическая ссылка.
  DT_REG     db " file ",0x0a, 0                                ;(значение 8) обычный файл.
  DT_SOCK   db " socket ",0x0a, 0                          ;(значение 12) сокет домена UNIX.
  DT_UNKNOWN   db "unknown device",0x0a, 0 ;неизвестный тип
  space db "  "

section '.bss' writable

  buffer rb len
  place rb len

section '.text' executable

_start:
    pop rcx
    cmp rcx, 2
    jne .l1

   ;;Открываем каталог на чтение
   mov rax, 2
   mov rdi, [rsp+8]
   mov rsi, 65536
   syscall
   cmp rax, 0
   jl .l1
   
   ;Сохраняем файловый дескриптор
   mov r8, rax

 .loop:
   
   ;;Читаем с винчестера len байт
   mov rax, 78
   mov rdi, r8
   mov rsi, buffer
   mov rdx, len
   syscall
   cmp rax, 0
   jle .l2
   mov r10, rax
   
   ;;текущая позиция в структуре
   xor rdx, rdx
   
   .loop2:
   ;;Печатаем d_ino
   mov rax, qword [buffer+rdx]
   cmp rax, 0
   je .loop	
   mov rsi, place
   call number_str
   call print_str
   mov rsi, space
   call print_str
   
   ;вычисляем размер структуры в r9
   xor r9,r9
   mov r9W, word [buffer+16+rdx]
   mov rax, r9
   mov rsi, place
   call number_str
   call print_str
   mov rsi, space
   call print_str

   ;печатаем имя файла
   mov rsi, buffer
   add rsi, 18
   add rsi, rdx
   call print_str

   mov al,byte[buffer + r9-1+rdx]
   call type_file
   
   add rdx, r9
   cmp rdx, r10
   jl .loop2

 jmp .loop

  ;;Закрываем чтение из каталога
.l2:   
   mov rax, 3
   mov rdi, r8
   syscall


.l1:
  call exit


;;input rax - number of file
;;output - print type of file
type_file:
 
   push rsi
   
   cmp rax, 1
   jne .l1
   mov rsi, DT_FIFO
   call print_str
   pop rsi
   ret
.l1:
   cmp rax, 2
   jne .l2
   mov rsi, DT_CHR
   call print_str
   pop rsi
   ret
.l2:
   cmp rax, 4
   jne .l3
   mov rsi, DT_DIR
   call print_str
   pop rsi
   ret
.l3:
   cmp rax, 6
   jne .l4
   mov rsi, DT_BLK
   call print_str
   pop rsi
   ret
.l4:
   cmp rax, 8
   jne .l5
   mov rsi, DT_REG
   call print_str
   pop rsi
   ret
.l5:
   cmp rax, 10
   jne .l6
   mov rsi, DT_LNK 
   call print_str
   pop rsi
   ret
.l6:
   cmp rax, 12
   jne .l7
   mov rsi, DT_SOCK 
   call print_str
   pop rsi
   ret
.l7:
   mov rsi, DT_UNKNOWN
   call print_str
   pop rsi
   ret
  
