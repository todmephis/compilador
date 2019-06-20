%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex();
int yyerror(char *s);
%}

%token PALRESERV COM ARG NUM PORT SEMICOLON TAGAI TAGAF TAGC

%type <cadena> PALRESERV
%type <cadena> COM
%type <cadena> ARG
%type <numeroentero> NUM
%type <cadena> directiva
%type <cadena> argumento
%type <cadena> serieargumentos
%type <cadena> comentario
%type <cadena> TAGAI
%type <cadena> TAGAF
%type <cadena> TAGC
%type <cadena> contenido
%type <cadena> listacontenido



%union{
	char cadena[300];
	int numeroentero;
}

%%
input:	%empty 
		| input linea
;

linea:	'\n'
		| grupodirectivas
		| grupodirectivas '\n'
		| comentario
		| comentario '\n'
		| directiva
		| directiva '\n'
;
grupodirectivas
			: TAGAI PALRESERV TAGAF listacontenido TAGC PALRESERV TAGAF
						{
							if(strcmp($2, $6) !=  0){
								fprintf(stderr, "Error, etiqueta de apertura y de cierre son diferentes\n");
								exit(EXIT_FAILURE);
								
							}
							printf("[BISON]directiva_agrupada: %s \n", $4);
						}
;

listacontenido 
			: contenido 
						{
							strcpy($$, $1);
						}
			| listacontenido contenido
						{
							strcat($$, $2);
						}
;


contenido 
			: comentario	{
								strcpy($$, $1);
								printf("[BISON]listadirectivas comentario: %s\n", $1);
							}
 		  	| directiva   	{	
	 		  					strcpy($$, $1);
								printf("[BISON]listadirectivas directiva: %s\n", $1);
							}
;

comentario	:	COM {
						strcpy($$, $1);
						printf("[BISON]Ingresaste un comentario: %s\n", $1);
					}
;

directiva:	PALRESERV serieargumentos SEMICOLON 
			{
				printf("$1 %s\n", $1);
				printf("$2 %s\n", $2);
				if((strcmp($1, "PuertoEscucha") ==  0) && (atoi($2) < 0 || atoi($2) > 65535)){
					printf("primer if\n");
					fprintf(stderr, "Error semántico: Puerto %d especificado fuera de rango.\n", atoi($2));
					exit(1);

				}
				else{
					strcat($$, "\n");
					strcat($$, $2);
					printf("[BISON]Ingresaste un directiva: %s %s\n", $1, $2);
				}
			}
;

serieargumentos: serieargumentos argumento  {
												strcat($$, " ");
												strcat($$, $2);
											}
;

serieargumentos: argumento {strcpy($$, $1);}
;

argumento:	ARG 	{strcpy($$, $1);}
			| NUM 	{
						if($1 < 0 )
							fprintf(stderr, "Error semántico: Número entero negativo detectado.\n");
						else
							sprintf($$, "%d", $1);
					}//{printf("[BISON]%d\n", $1);}
;

%%

int yyerror(char *s)
{
	fprintf(stderr, "[BISON ERROR]%s\n", s);
	return 0;
}

int main(void)
{
    yyparse();
    return 0;
}