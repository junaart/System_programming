asm_pids: pids.asm
	fasm pids.asm

comp_pids: asm_pids
	ld pids.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o pids

run_pids: comp_pids
	./pids

clear:
	rm -f ./pids ./pids.o ./pids_c

comp_pids_c: pids.c
	gcc pids.c -o pids_c

run_pids_c: comp_pids_c
	./pids_c

asm_execve: execve.asm
	fasm execve.asm

comp_execve: asm_execve
	ld execve.o -o execve

asm_pids_fork: pids_fork.asm
	fasm pids_fork.asm

comp_pids_fork: asm_pids_fork
	ld pids_fork.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o pids_fork

run_pids_fork: comp_pids_fork
	./pids_fork

asm_fork_exec: fork_exec.asm
	fasm fork_exec.asm

comp_fork_exec: asm_fork_exec
	ld fork_exec.o  -o fork_exec

asm_fork_exec_2: fork_exec_2.asm
	fasm fork_exec_2.asm

comp_fork_exec_2: asm_fork_exec_2
	ld fork_exec_2.o  -o fork_exec_2

comp_delay: delay.c
	gcc -c delay.c -o delay.o

asm_fork_exec_3: fork_exec_3.asm 
	fasm fork_exec_3.asm

comp_fork_exec_3: asm_fork_exec_3
	ld fork_exec_3.o  -o fork_exec_3
