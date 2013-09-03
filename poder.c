#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define TAM_INI_CADENA 40


//Lee una linea de tamanio arbitrario. Devuelve NULL al llegar a EOF
char* leerLinea(FILE* archivo){
    int tam = TAM_INI_CADENA,i=0;
    char *linea = (char*)malloc(sizeof(char)*tam);
    char letra;
    do {
        letra = fgetc(archivo);
        linea[i]=letra;
        if (tam==i+1){
            tam+=10;
            char *aux=(char*) realloc(linea,sizeof(char)*tam);
            if (!aux) {
                linea[i]='\0';
                return linea;
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
    return linea;
}


void invertirLinea(char* linea){
    if (!linea)
	return;
    int len = strlen(linea);
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
	
	int i = 0;
	
	while (i < nFiles){
		if (! noFile){
			file = fopen(argv[i+1],"r");
		}
		
		while (!feof(file)){
			char* s=leerLinea(file);
			invertirLinea(s);
			if (s){
				printf("%s\n",s);
				free(s);
			}
		}
		
		i++;
		if (! noFile){
			fclose(file);
		}
	}
	
	return 0;
}
