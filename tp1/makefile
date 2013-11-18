CFLAGS=-Wall -pedantic -std=c99 -g
MEMFLAGS=valgrind --leak-check=full --track-origins=yes -v
CC=gcc
MAIN=main.c
INPUT=reverse.S
MIDDLEFILE=reverse.o
EXEC=main


all: $(EXEC) clean
test: all runTests cleanExec


.SILENT:
$(MIDDLEFILE): reverse.h reverse.S
        $(CC) $(CFLAGS) -c reverse.S -o reverse.o

.SILENT:
$(EXEC): $(MIDDLEFILE) $(MAIN) 
        $(CC) $(CFLAGS) $(MIDDLEFILE) $(MAIN) -o $(EXEC)

.SILENT:        
run: $(EXEC)
        ./$(EXEC)

.SILENT:
clean: $(MIDDLEFILE)
        rm *.o

.SILENT:
cleanExec: $(EXEC)
        rm $(EXEC)