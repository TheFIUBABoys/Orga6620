#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

int main(int argc, char * const argv[]){
	size_t i;
	size_t j;
	char *p;

	for (i = 1000; i<2000; ++i) {
		fprintf(stdout, "malloc(%ld) ...", (long)40);
		fflush(stdout);
		p = (char *) malloc(40);
		fprintf(stdout, " %p.", p);

		fprintf(stdout, "remalloc(%ld) ...", (long) 80);
                fflush(stdout);
                p = (char *) realloc(p,80);
                fprintf(stdout, " %p.", p);

		
		printf(" Freeing memory ...");
		fflush(stdout);
		free(p);
		printf(" Ok.\n");
		fflush(stdout);
	}

	return 0;
}
