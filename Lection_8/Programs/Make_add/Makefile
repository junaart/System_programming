asm: stat_array.asm
	fasm stat_array.asm

c: asm stat_array.c 
	gcc stat_array.c stat_array.o -o myprog

run: c myprog
	./myprog

clean:
	rm -f *.o

