all: mbr.o a.out mbr.img

mbr.o: mbr.S
	gcc -ggdb -c mbr.S

a.out: mbr.o
	ld mbr.o -Ttext 0x7c00

mbr.img: mbr.o
	objcopy -S -O binary -j .text a.out mbr.img

run:
	qemu-system-x86_64 mbr.img

clean:
	rm -f mbr.o a.out mbr.img 