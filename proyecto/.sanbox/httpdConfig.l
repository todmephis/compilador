%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//#include "httpdConfig.tab.h"
//void showError();
%}

L			[a-zA-Z ]

%%
"NombreServidor"	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						
					}

"RaizServidor"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"PuertoEscucha" 	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"AdminServidor" 	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"UsuarioApache"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"GrupoApache"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"ArchivoPid"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

"RaizDeDocumentos"	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
					}

^#{L}+				{	printf("[LEX]Comentario detectado: %s\n", yytext);
					}

[[:digit:]]+	 	{
						printf("[LEX]Número entero: %s\n", yytext);
					}


\"(\\.|[^\\"\n])*\"	{
						printf("[LEX]Argumento: %s\n", yytext);
					}

";"      		   	{		}

[\n] 				{}
     
[ \t]+
"<"					{printf("[LEX]Tag Apertura: %s\n", yytext);}

">"					{printf("[LEX]Tag Apertura cierre: %s\n", yytext);	}

"</"					{printf("[LEX]Tag Apertura Fin: %s\n", yytext);	}
.					{printf("Error\n"); exit(EXIT_FAILURE);}
<<EOF>> 				{  }



%%

/* void showError(){
    printf("Other input");
    exit(1);
} */