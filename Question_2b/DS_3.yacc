%{

#include<stdio.h>

//yacc error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int deep = 0;

%}

%union {
    char* str;
}

%token <str> NOM_DOC TITRESECTION CHAINE IMAGE
%token DEBUT_DOC FIN_BALISE FIN_DOC DEBUT_IMAGE DEBUT_VERSION NUM_VERSION DEBUT_DATE
%token DATE DEBUT_TITRE DEBUT_SECTION SECTION FIN_SECTION 

%start START
%%


DOC : DEBUT_DOC NOM_DOC FIN_BALISE DEBUT_VERSION NUM_VERSION FIN_BALISE DEBUT_DATE DATE FIN_BALISE DEBUT_TITRE TITRESECTION FIN_BALISE INSIDE

INSIDE :  DEBUT_SECTION TITRESECTION FIN_BALISE {
                                                    deep++;
                                                    printf("%i %s\n", deep, $2);
                                                }
            CONTENT {
                        deep--;
                    }
            FIN_SECTION INSIDE
       |
       ;

CONTENT : INSIDE
        | DEBUT_IMAGE IMAGE {   
                                deep++;
                                printf("%i %s\n", deep, $2);
                            }
          FIN_BALISE {
                        deep--;
                     }
          CONTENT
        | CHAINE CONTENT
        ;

START : DOC FIN_DOC {
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
