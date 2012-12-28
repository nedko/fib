asm:
	yasm -f elf fib.asm -o fib.o
	ld -s fib.o -o fib
	rm fib.o

clang:
	clang -Wall -Wextra -Werror fib.c -std=c99 -O1 -o fib

gcc:
	gcc -Wall -Wextra -Werror fib.c -O1 -o fib

time:
	/usr/bin/time -v ./fib

strace:
	/usr/bin/strace ./fib

disasm:
	/usr/bin/objdump -d -Mintel ./fib

clean:
	-rm fib
