sum_asm: call_sum.asm
	fasm call_sum.asm

sum_c: sum.c
	gcc -c sum.c -o sum.o

build: sum_asm sum_c
	ld sum.o call_sum.o -o myprog

run: sum_asm sum_c build myprog
	./myprog $(var)

clean:
	rm -f *.o

