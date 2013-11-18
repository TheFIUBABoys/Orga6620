#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <unistd.h>
#include <math.h>

#define TAM_INI_CADENA 40
#define MALLOC_ERROR 1
#define REALLOC_ERROR 2
#define FGETC 3

//Lee una linea de tamanio arbitrario. Devuelve 0 si la lectura fue exitosa o un numero mayor a 0 si hubo un error. Ademas guarda en size el tamanio de la linea leida
int leerLinea(FILE* archivo, char** linea,int* size){
    int tam = TAM_INI_CADENA,i=0;
    *linea = (char*)malloc(sizeof(char)*tam);
    if(!(*linea))
    	return MALLOC_ERROR;
    char letra;
    do {
        letra = fgetc(archivo);
        if(ferror(archivo)!=0)
        	return FGETC;
        (*linea)[i]=letra;
        if (tam==i+1){
        	tam=(int) pow((double) tam,1.51);
            char *aux=(char*) realloc(*linea,sizeof(char)*tam);
            if (!aux) {
            	return REALLOC_ERROR;
            } else {
                *linea=aux;
            }
        }
        i++;
    } while (letra!='\n' && letra!=EOF);
    *size=i;
    return 0;
}


void invertirLinea(char* linea,int len){
	if (!linea || len<3)
	return;
    int i = 0;
    int l = len-2;
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
	FILE* file;
	bool noFile = false;


	if (nFiles == 0){
		file = stdin;
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
	int error=0;
	while (i < nFiles && error==0){
		if (! noFile){
			file = fopen(argv[i+1],"r");
		}
		
		if(!file){
			fprintf(stderr,"Error in File %s open\n",argv[i+1]);
		}
		else{
			while (!feof(file)&& error==0){
				char* s=NULL;
				int size=0;
				error=leerLinea(file,&s,&size);
				if(error==0){
					invertirLinea(s,size);
					if (s)
						if(s[size-1]==EOF)
							size--;
						write(1,s,size);
				}
				if(s)
					free(s);
			}
		}
		i++;
		if (! noFile && file){
			fclose(file);
		}
	}
	return error;
}
