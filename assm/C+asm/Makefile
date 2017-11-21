

go: main.o printf.o
	gcc -o $@ $^

printf.o: printf.asm
	nasm -g -f elf64 -o $@ $^

main.o: main.c
	gcc -c $^
