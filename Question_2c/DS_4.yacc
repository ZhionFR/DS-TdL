%{

#include<stdio.h>

//yacc error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/*
document    
    section
        image
        section
            image 
        fin
        image = 1
    fin
    image = 2


pile : a,b,c
rentre section : add(nouvelle case)
sort section : remove()
image : +1 tout le monde
*/

typedef struct pile { // pile jamais vide car toujours 1er elt = total images
    int elt;
    struct pile *queue;
} T_pile;

T_pile* initPile(){
    T_pile* new = (T_pile*)malloc(sizeof(T_pile));
    new->elt = 0;
    new->queue = NULL;
    return new;
}

T_pile* empile(T_pile* pile, int newelt){
    T_pile* new = (T_pile*)malloc(sizeof(T_pile));
    new->elt = newelt;
    new->queue = pile;
    return new;
}

int getfirst(T_pile* pile){
    return pile->elt;
}

T_pile* depile(T_pile* pile){
    T_pile* tete = pile;
    pile = pile->queue;
    free(tete);
    return pile;
}

T_pile* addAllOnes(T_pile* pile){
    T_pile* current = pile;
    while((current->queue)!=NULL){
        current->elt = current->elt +1;
        current = current->queue;
    }
    return pile;
}

int deep = 0;
T_pile* Images;
int totalImg = 0;

void printIdentation() {
    for (int i = 0; i < deep * 2; i++) {
        printf(" ");
    }
}
%}

%union {
    char* str;
}

%token <str> NOM_DOC TITRESECTION CHAINE IMAGE
%token DEBUT_DOC FIN_BALISE FIN_DOC DEBUT_IMAGE DEBUT_VERSION NUM_VERSION DEBUT_DATE
%token DATE DEBUT_TITRE DEBUT_SECTION SECTION FIN_SECTION 

%start START
%%


DOC : DEBUT_DOC NOM_DOC FIN_BALISE DEBUT_VERSION NUM_VERSION FIN_BALISE DEBUT_DATE DATE FIN_BALISE DEBUT_TITRE TITRESECTION FIN_BALISE { Images = initPile(); } INSIDE

INSIDE :  DEBUT_SECTION TITRESECTION FIN_BALISE {   
                                                    printIdentation();
                                                    Images = empile(Images, 0);
                                                    deep++;
                                                    printf("%i %s\n", deep, $2);
                                                }
            CONTENT {
                        deep--;
                        printIdentation();
                        printf("%i images.\n", getfirst(Images));
                        Images = depile(Images);
                    }
            FIN_SECTION INSIDE
       |
       ;

CONTENT : INSIDE
        | DEBUT_IMAGE IMAGE {   
                                printIdentation();
                                deep++;
                                addAllOnes(Images);
                                totalImg++;
                                printf("%i %s\n", deep, $2);
                            }
          FIN_BALISE {
                        deep--;
                     }
          CONTENT
        | CHAINE CONTENT
        ;

START : DOC FIN_DOC {   
                        printf("Le document contient %i images\n", totalImg);
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
