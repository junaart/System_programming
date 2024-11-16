asm_set_uid: get_set_uid.asm
	fasm get_set_uid.asm

link_set_uid: asm_set_uid
	ld get_set_uid.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o prog
	
asm_set_gid: get_set_gid.asm
	fasm get_set_gid.asm

link_set_gid: asm_set_gid
	ld get_set_gid.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o prog
	
asm_set_priory: get_set_priory.asm
	fasm get_set_priory.asm

link_set_priory: asm_set_priory
	ld get_set_priory.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o prog
	
asm_sig_ign: sig_ign.asm
	fasm sig_ign.asm

link_sig_ign: asm_sig_ign
	ld sig_ign.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o prog
	
asm_kill_stop: kill_stop.asm
	fasm kill_stop.asm

link_kill_stop: asm_kill_stop
	ld kill_stop.o -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o prog
