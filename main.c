#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>

#define TAM_INI_CADENA 40


//Lee una linea de tamanio arbitrario. Devuelve NULL al llegar a EOF
char* leerLinea(FILE* archivo,int* largo){
    int tam = TAM_INI_CADENA,i=0;
    char *linea = (char*)malloc(sizeof(char)*tam);
    if (!linea)
    	return NULL;
    char letra;
    do {
        letra = fgetc(archivo);
	if (!letra){
		fprintf(stderr,"An error has occurred while reading file. The program will exit now.");
		exit(3);
	}
        linea[i]=letra;
        if (tam==i+1){
            tam=(int) pow((double) tam,1.51);
            char *aux=(char*) realloc(linea,sizeof(char)*tam);
            if (!aux) {
                fprintf(stderr,"An error has occurred while reading file. The program will exit now.");
		exit(2);
            } else {
                linea=aux;
            }
        }
        i++;
    } while (letra!='\n' && letra!=EOF);
    linea[i-1]='\0';
    
 	if (i-1 == 0 ){
 		free(linea);
 		return NULL;
 	}
 	*largo=i-1;
    return linea;
}


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
	
	while (i < nFiles){
		if (! noFile){
			file = fopen(argv[i+1],"r");
		}
		
		if(!file){
			fprintf(stderr,"An error has occurred while opening file %s\n. The program will exit now.",argv[i+1]);
			exit(1);
		} else
		while (!feof(file)){
			int largo = 0;
			char* s=leerLinea(file,&largo);
			invertirLinea(s,largo);
			if (s){
				printf("%s\n",s);
				free(s);
			}
		}
		i++;
		if (! noFile && file){
			fclose(file);
		}
	}
	
	return 0;
}
