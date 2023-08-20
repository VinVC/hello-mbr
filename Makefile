all: mbr.o a.out mbr.img

mbr.o: mbr.S
	gcc -ggdb -c mbr.S

a.out: mbr.o
	ld mbr.o -Ttext 0x7c00

mbr.img: mbr.o
	objcopy -S -O binary -j .text a.out $@

run: mbr.img
	qemu-system-x86_64 $<

debug: mbr.img
	qemu-system-x86_64 -s -S $< &   # run qemu in background
	gdb -x init.gdb   # RTFM: gdb(1)

clean:
	rm -f mbr.o a.out mbr.img 