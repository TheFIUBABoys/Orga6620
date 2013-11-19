#include <stdio.h>
#include <sys/types.h>
#include "mymalloc.h"

int main(int argc, char * const argv[]){
	size_t i;
	size_t j;
	char *p;

	for (i = 1000; i<2000; ++i) {
		fprintf(stdout, "malloc(%ld) ...", (long) 40);
		fflush(stdout);
		p = (char *) mymalloc(40);
		fprintf(stdout, " %p.", p);

		fprintf(stdout, "remalloc(%ld) ...", (long) 80);
		fflush(stdout);
		p = (char *) myrealloc(p,80);
		fprintf(stdout, " %p.", p);


	
		printf(" Freeing memory ...");
		fflush(stdout);
		myfree(p);
		printf(" Ok.\n");
		fflush(stdout);
	}

	return 0;
}
