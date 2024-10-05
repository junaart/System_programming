format elf64
public _start

include 'func.asm'

section '.data' writable

buffer rb 101

section '.text' executable

_start:
   pop rcx ;читаем количество параметров командной строки
   cmp rcx, 1 ;если один параметр(имя исполняемого файла)
   je .l1 ;завершаем работу

   mov rdi,[rsp+8] ;загружаем адрес имени файла из стека
   mov rax, 2 ;системный вызов открытия файла
   mov rsi, 0o ;Права только на чтение
   syscall
   cmp rax, 0 ;если вернулось отрицательное значение,
   jl .l1 ;то произошла ошибка открытия файла, также завершаем работу
   
   mov r8, rax ;сохраняем файловый дескриптор
   xor r9, r9  ;счетчик количества прочитанных байт
.loop_read: ;начинаем цикл чтения из файла
   mov rax, 0 ;номер системного вызова чтения
   mov rdi, r8 ;загружаем файловый дескриптор
   mov rsi, buffer ;указываем, куда помещать прочитанные данные
   mov rdx, 100 ;устанавливаем количество считываемых данных
   syscall ;выполняем системный вызов read
   cmp rax, 0 ;если прочитано 0 байт, то достигли конца файла 
   je .next  ;выходим из цикла чтения
   add rax, r9
   xchg rax, r9	
   jmp .loop_read ;продолжаем цикл чтения
.next: 
   xchg rax, r9
   mov rsi, buffer
   call number_str	
   call print_str
   call new_line	
  ;;Системный вызов close
   mov rdi, r8
   mov rax, 3
   syscall
   
.l1:
   call exit
