#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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


int main(){
	FILE* ejemplo = fopen("ejemplo","r");
	
	while (!feof(ejemplo)){
		char* s=leerLinea(ejemplo);
		invertirLinea(s);
		if (s){
			printf("%s\n",s);
			free(s);
		}
	}
	fclose(ejemplo);
	return 0;
}
