%{
#include<stdio.h>
%}
%token DEBUT_DOC NOM_DOC DEBUT_VERSION NUM_VERSION DEBUT_DATE DATE DEBUT_TITRE TITRE DEBUT_SECTION SECTION FIN_SECTION DEBUT_IMAGE IMAGE CHAINE FIN_BALISE FIN_DOC
%start S

%%

S              : doc version date titre section FIN_DOC { printf("Document accepté"); YYACCEPT ; }
doc            : DEBUT_DOC NOM_DOC FIN_BALISE
version        : DEBUT_VERSION NUM_VERSION FIN_BALISE
date           : DEBUT_DATE DATE FIN_BALISE
titre          : DEBUT_TITRE TITRE FIN_BALISE 
section        : DEBUT_SECTION SECTION soussection section FIN_SECTION section
               | 
               ;
soussection    : DEBUT_IMAGE IMAGE FIN_BALISE soussection
               | CHAINE soussection
               | 
               ;

%%

#include "lex.yy.c"
int main(){
    yyparse();
    printf("voilà, j'ai interprété\n");
}
