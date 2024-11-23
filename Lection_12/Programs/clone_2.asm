;;clone_2.asm
	
	format elf64
	public _start
	include 'func.asm'
	
	THREAD_FLAGS=2147585792


	section '.data' writable
	
	max db 0,0
	min db 0,0
	array db 'abcdefhzw'
	len=$-array
	
	section '.bss' writable
	
	stack_1 rq 4096 
	stack_2 rq 4096
	
	buffer rb 100
	
	section '.text' executable
	
_start:

   ;;Запускаем первый тред
   mov rdi, THREAD_FLAGS
   mov rsi, 4096
   add rsi, stack_1
   mov rax, 56
   syscall
   cmp rax,0
   je thread_1
   
   ;;Запускаем второй тред
   mov rdi, THREAD_FLAGS
   mov rsi, 4096
   add rsi, stack_2
   mov rax, 56
   syscall
   cmp rax,0
   je thread_2
   
   ;;Ждем
   call input_keyboard
   
   ;;Печатаем результаты

   mov rsi,min
   call print_str
   call new_line
   
   mov rsi,max
   call print_str
   call new_line
   
   call exit
   
	
thread_1:
  mov rcx, 0
  xor rdx, rdx
  mov dl, [array]
  .loop_find_min:
  cmp dl, [array+rcx]
  jl .p
  mov dl, [array+rcx]
  .p:
  inc rcx
  cmp rcx, len
  jl .loop_find_min
  mov [min], dl
  call exit 
  
thread_2:
  mov rcx, 0
  xor rdx, rdx
  mov dl, [array]
  .loop_find_max:
  cmp dl, [array+rcx]
  jg .p
  mov dl, [array+rcx]
  .p:
  inc rcx
  cmp rcx, len
  jl .loop_find_max
  mov [max], dl
  call exit
  
	
