gcc -c reverse.S
gcc -c ./sys_mmap/mymalloc.S -o ./mymalloc.o
gcc mymalloc.o reverse.o main.c -o tp1