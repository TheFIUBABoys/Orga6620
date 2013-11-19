#include <stdio.h>
#include <sys/types.h>
#include "mymalloc.h"

int main(int argc, char * const argv[]){
	size_t i;
	size_t j;
	char *p;

	for (i = 1; i; ++i) {
		fprintf(stdout, "malloc(%ld) ...", (long) i);
		fflush(stdout);
		p = (char *) mymalloc(i);
		fprintf(stdout, " %p.", p);

		printf(" Writing ...");
		fflush(stdout);
		for (j = 0; j < i; ++j)
			p[j] = 0x10;
		printf(" Ok.");
		
		fprintf(stdout, "myrealloc(%p,%ld) ...",p, (long) i*2);
		fflush(stdout);
		p = (char *) myrealloc(p,i*2);
		fprintf(stdout, " %p.", p);
		printf(" Checking...");
		fflush(stdout);
		int error = 1;
		for (j = 0; j < i; ++j){
			if (p[j] != 0x10)
				error = 0;
		}
		if (error != 0)
			printf(" Ok.");
		else
			printf(" Error.");
			
		printf(" Writing ...");
		fflush(stdout);
		for (j = i; j < i*2; ++j)
			p[j] = 0x10;
		printf(" Ok.");	

		printf(" Freeing memory ...");
		fflush(stdout);
		myfree(p);
		printf(" Ok.\n");
		fflush(stdout);
	}

	return 0;
}
