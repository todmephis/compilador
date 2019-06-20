%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "httpdConfig.tab.h"
//void showError();
%}

L			[a-zA-Z ]

%%
"NombreServidor"	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"RaizServidor"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"PuertoEscucha" 	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"AdminServidor" 	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"UsuarioApache"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"GrupoApache"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);	
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"ArchivoPid"		{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

"RaizDeDocumentos"	{	printf("[LEX]Palabra reservada detectada: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (PALRESERV);
					}

^#{L}+				{	printf("[LEX]Comentario detectado: %s\n", yytext);
						sscanf(yytext, "%s", yylval.cadena); return (COM);
					}

[[:digit:]]+	 	{
						printf("[LEX]Número entero: %s\n", yytext);
						yylval.numeroentero = atoi(yytext); 
						return NUM;
					}


\"(\\.|[^\\"\n])*\"	{
						printf("[LEX]Argumento: %s\n", yytext);sscanf(yytext, "%s", yylval.cadena); 
						return (ARG);
					}

";"      		   	{	return (SEMICOLON);	}

[\n] 				{printf("[LEX]Salto linea\n"); return yytext[0];}
     
[ \t]+


"<"					{printf("[LEX]Tag Apertura Inicio: %s\n", yytext);	return (TAGAI);	}

">"					{printf("[LEX]Tag Cierre: %s\n", yytext);	return (TAGAF);	}

"</"				{printf("[LEX]Tag Apertura Fin: %s\n", yytext);	return (TAGC);	}
.					{printf("Error\n"); exit(EXIT_FAILURE);}
<<EOF>> 			{ return yytext[0]; }


%%

/* void showError(){
    printf("Other input");
    exit(1);
} */