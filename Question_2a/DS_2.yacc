%{

#include<stdio.h>

//yacc error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

%}
%token DEBUT_DOC NOM_DOC FIN_BALISE FIN_DOC DEBUT_IMAGE IMAGE DEBUT_VERSION NUM_VERSION DEBUT_DATE
%token DATE DEBUT_TITRE TITRESECTION DEBUT_SECTION SECTION FIN_SECTION CHAINE

%start START
%%

DOC : DEBUT_DOC NOM_DOC FIN_BALISE DEBUT_VERSION NUM_VERSION FIN_BALISE DEBUT_DATE DATE FIN_BALISE DEBUT_TITRE TITRESECTION FIN_BALISE INSIDE

INSIDE :  DEBUT_SECTION TITRESECTION FIN_BALISE CONTENT FIN_SECTION INSIDE
      |
      ;

CONTENT : INSIDE
        | DEBUT_IMAGE IMAGE FIN_BALISE CONTENT
        | CHAINE CONTENT
        ;

START : DOC FIN_DOC {
                        printf("Document accepté\n");
                        YYACCEPT;
                    }
    ;

%%
#include "lex.yy.c"
int main(){
    yyparse();
    printf("Done.\n");
}

/* hmmm */
