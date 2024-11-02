	;; example5_2.asm
	format ELF64

	public _start
	;; Указываем необходимые внешние функции из библиотки ncurses
	extrn initscr
	extrn printw
	extrn refresh
	extrn getch
	extrn endwin
	extrn exit
	extrn stdscr
	extrn getmaxx
	extrn getmaxy
	extrn move
	

	section '.data'

	hello db "Hello World!",0

	section '.text' executable

_start:
	call initscr
	mov rdi, [stdscr] 	;загружаем экран в rdi для вызова getmaxx
	call getmaxx			
	mov r8, rax		;сохраняем максимальный размер по x в регистре r8
	call getmaxy	
	mov r9, rax 		;сохраняем максимальный размер по y в регистре r9
	xor rdx, rdx		;находим координаты середины экрана
	mov rax,r9
	mov rcx, 2
	div rcx
	mov r9, rax 		;загружаем середину по y в r9
	xor rdx, rdx
	mov rax,r8
	mov rcx, 2
	div rcx
	mov r8, rax		;загружаем середину по x в r8
	mov rdi, r9		;подготавливаем входные параметры для вызова move
	mov rsi, r8
	call move		;перемещаем курсор в середину экрана
	mov rdi, hello		;загружаем в rdi адрес сообщения
	call printw		;выводим сообщение в текущй позиции
	call refresh		;обновляем экран для визуализации изменений
	call getch			;ожидаем ввода любого символа
	call endwin		;закрываем экран, возвращаемся в обычный режим
	call exit 			;используем встроенную в ncurses функцию выхода
