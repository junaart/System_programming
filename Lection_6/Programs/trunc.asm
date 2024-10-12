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
     pop rcx 
     cmp rcx, 1 
     je .l1

     mov rdi,[rsp+8] 
     mov rax, 2 
     mov rsi, 2o ;права на чтение и запись 
     syscall 
     cmp rax, 0 
     jl .l1 

    mov r8, rax ;сохраняем файловый дескриптор
    mov rax, 4
    mov rsi, mystat
    syscall

    ;;считываем размер файла
    xor rax, rax
    mov rax, [mystat.st_size]
    
    ;;удваиваем размер
    xor rdx,rdx
    mov rcx,2
    mul rcx
    
    mov r9,rax

   ;;выполняем усечение
   mov rax, 77
   mov rdi, r8
   mov rsi, r9
   syscall
   
   ;;Системный вызов close
   mov rdi, r8
   mov rax, 3
   syscall
   

.l1:
    call exit
