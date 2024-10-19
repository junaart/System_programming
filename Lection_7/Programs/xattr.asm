;;Пример использования расширенных параметров
format elf64
public _start

len = 200

include 'func.asm'

section '.bss' writable

  buffer rb len

section '.text' executable

_start:
  ;Считываем количество параметров командной строки
   pop rcx
   cmp rcx, 2
   jne .l2

   ;Читаем список расширенных параметров
   mov rdi, [rsp+8]
   mov rsi, buffer
   mov rdx, len
   mov rax, 194
   syscall

   ;Сохраняем количество байт под расширенные параметры
   mov r8, rax
   ;Устанавливаем текущее смещение
   mov r9,0
 .loop:
   cmp r9,r8
   je .l1
   ;Находит длину текущего параметра
   mov rax, rsi
   call len_str
   add r9, rax
   inc r9
   call print_str
   call new_line
   mov rax, buffer
   add rax, r9
   mov rsi, rax
   jmp .loop

;Получаем значение расширенного атрибута
.l2:
   cmp rcx, 3
   jne .l3
   mov rdi, [rsp+16]
   mov rsi, [rsp+8]
   mov rdx, buffer
   mov r10, len
   mov rax, 191
   syscall
   mov rsi, buffer
   call print_str
   call new_line
   jmp .l1

;Устанавливаем или удаляем значение расширенного атрибута
.l3:
   cmp rcx, 4
   jne .l1
   mov rax,[rsp+8]
   cmp byte [rax], 'd'
   je .l4
   ;;Находим длину значения
   mov rax, [rsp+16]
   call len_str
   mov r10, rax
   ;inc r10
   mov rdi,[rsp+24]
   mov rsi, [rsp+8]
   mov rdx, [rsp+16]
   xor r8,r8
   mov rax, 188
   syscall
   jmp .l1

.l4:
   mov rdi,[rsp+24]
   mov rsi, [rsp+16]
   mov rax, 197
   syscall

.l1:
   call exit
