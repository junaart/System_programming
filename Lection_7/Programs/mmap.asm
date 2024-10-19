;;Пример использования отображения в память
format elf64
public _start

include 'func.asm'

section '.data' writable

name_file db "test",0

section '.text' executable

_start:


;;Открываем файл на запись-чтение
   mov rax, 2
   mov rdi, name_file
   mov rsi, 2
   mov rdx, 777o
   syscall
   mov r12, rax
   
;;выполняем отображение файла в память
   mov rdi, 0    ;начальный адрес выберет сама ОС
   mov rsi, 4096 ;задаем длину равную размеру страницы
   mov rdx, 0x3  ;совмещаем флаги PROT_READ | PROT_WRITE
   mov r10,0x01  ;задаем режим MAP_SHARED
   mov r8, r12   ;указываем файловый дескриптор
   mov r9, 0     ;задаем нулевое смещение
   mov rax, 9    ;номер системного вызова mmap
   syscall
   
   mov rsi, rax  ;Сохраняем адрес памяти, куда отобразился файл
   
   call input_keyboard  ;вводим с клавиатуры в файл


;;выполняем системный вызов munmap
   mov rdi, rsi
   mov rsi, 4096
   mov rax, 11
   syscall

;;Системный вызов close
   mov rdi, r12
   mov rax, 3
   syscall
   call exit
