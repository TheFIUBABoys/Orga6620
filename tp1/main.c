#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "reverse.h"


//Lee una linea de tamanio arbitrario. Devuelve NULL al llegar a EOF


void invertirLinea(char* linea,int len){
    if (!linea)
		return;
    int i = 0;
    int l = len-1;
    while (l > i){
		//Swap
		char aux = linea[i];
		linea[i]=linea[l];
		linea[l]=aux;
		i++;
		l--;
    }
    
}


int main(int argc, char** argv){
	//FILE* ejemplo = fopen("ejemplo","r");	
	int nFiles = argc - 1;
	int file;
	bool noFile = false;


	if (nFiles == 0){
		file = 0; // stdin
		nFiles = 1;
		noFile = true;
	}
	else if (strcmp(argv[1],"-h")==0 && (nFiles==1)){
		printf("Usage:\ntp0 -h\ntp0 -V\ntp0 [file...]\nOptions:\n-V, --version  Print version and quit.\n-h, --help  Print this information and quit.\nExamples:\ntp0 foo.txt bar.txt\ntp0 gz.txt\n");
		return 0;		
		}
	else if (strcmp(argv[1],"-V")==0 && (nFiles==1)){
		printf("Tp0 Version 1.0");
		return 0;		
		}

	int i = 0;
	int res = 0;
	while (i < nFiles){
		if (! noFile){
			file = open(argv[i+1],O_RDONLY);
		}
		
		if(file < 0){ // file < 0 es error
			fprintf(stderr,"An error has occurred while opening file %s\n. The program will exit now.",argv[i+1]);
			exit(1);
		} else { 
			res=reverse(file, 1); // 1 es stdout
			
			/*
			//	LEER LINEA DEBUG MODE: ON
			int lineLength;
			printf("Linea: %s\n",leerLinea(file,&lineLength));
			printf("length: %d\n",lineLength);
			//	LEER LINEA DEBUG MODE: OFF
			*/
			
			close(file);
			if(res != 0){
				printf("%s\n",reverse_errmsg[res]);
				return res;
			}
		}
		i++;
	}
	printf("%s\n",reverse_errmsg[res]);
	return 0;
}
