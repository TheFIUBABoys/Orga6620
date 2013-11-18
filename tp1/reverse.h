#ifndef REVERSE_H
#define REVERSE_H

#include <stdio.h>
#include "sys_mmap/mymalloc.h"



#define TAM_INI_CADENA 40

extern const char* reverse_errmsg[];

int reverse(int infd, int outfd);

#endif
