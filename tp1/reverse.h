#ifndef REVERSE_H
#define REVERSE_H

#include <stdio.h>
#include "sys_mmap/mymalloc.h"

extern const char* reverse_errmsg[];

int reverse(int infd, int outfd);

char* leerLinea(int fd,int* length);

#endif
