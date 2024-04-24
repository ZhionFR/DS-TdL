%{
#include<stdio.h>
%}
%token DEBUT_DOC NOM_DOC DEBUT_VERSION NUM_VERSION DEBUT_DATE DATE DEBUT_TITRE TITRE DEBUT_SECTION SECTION FIN_SECTION DEBUT_IMAGE IMAGE CHAINE FIN_BALISE FIN_DOC
%start S

%%

S : S1 S2 FIN_DOC { printf("Document accepté"); YYACCEPT ; }
S1 : DEBUT_DOC NOM_DOC FIN_BALISE DEBUT_VERSION NUM_VERSION FIN_BALISE DEBUT_DATE DATE FIN_BALISE DEBUT_TITRE TITRE FIN_BALISE 
S2 : DEBUT_SECTION SECTION S3 FIN_SECTION S2
   | 
   ;
S3 : S2
   | DEBUT_IMAGE IMAGE FIN_BALISE S3
   | CHAINE S3
   ;

%%

#include "lex.yy.c"
int main(){
    yyparse();
    printf("voilà, j'ai interprété");
}