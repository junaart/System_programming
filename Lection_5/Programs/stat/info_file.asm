format elf64
public _start



include 'func.asm'

section '.bss' writable

Struc stat
{
  .st_dev dq ?        
  .st_ino dq ?
  .st_nlink dq ? 
  .st_mode dd ?
  .st_uid dd ?        
  .st_gid dd ?        
  .st_rdev dq ?  
  .st_res_1 dd ?       
  .st_size dq ?        
  .st_blksize dq ?     
  .st_blocks dq ?      
  .st_atime dq ?  
  .st_atime_nsec dq ?   
  .st_mtime dq ? 
  .st_mtime_nsec dq ?    
  .st_ctime dq ?       
  .st_ctime_nsec dq ? 
}

buffer rb 200
mystat stat 

section '.text' executable

_start:
   pop rcx ;читаем количество параметров командной строки
   cmp rcx, 1 ;если один параметр(имя исполняемого файла)
   je .l1 ;завершаем работу

   mov rdi,[rsp+8] ;загружаем адрес имени файла из стека
   mov rax, 2 ;системный вызов открытия файла
   mov rsi, 0o ;Права только на чтение
   syscall ;системный вызов открытия файла
   cmp rax, 0 ;если вернулось отрицательное значение,
   jl .l1 ;то произошла ошибка открытия файла, также завершаем работу

   mov r8, rax ;сохраняем файловый дескриптор
   mov rax, 4
   mov rsi, mystat
   syscall

   ;;Системный вызов close
   mov rdi, r8
   mov rax, 3
   syscall

   xor rax, rax
   mov rax, [mystat.st_dev]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_ino]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_nlink]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov eax, dword [mystat.st_mode]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov eax, dword [mystat.st_uid]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov eax, dword [mystat.st_gid]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_rdev]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_size]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_blksize]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line
   
   xor rax, rax
   mov rax, [mystat.st_blocks]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line
   
   xor rax, rax
   mov rax, [mystat.st_atime]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line
   
   xor rax, rax
   mov rax, [mystat.st_mtime]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

   xor rax, rax
   mov rax, [mystat.st_ctime]
   mov rsi, buffer
   call number_str
   mov rsi, buffer
   call print_str
   call new_line

.l1:
   call exit
