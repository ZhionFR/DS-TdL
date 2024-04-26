%{
#include <stdio.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }
int count = 0; // Niveau d'indentation actuel (profondeur de la section)
int image_count = 0; // Nombre d'images dans la section courante
int total_images = 0; // Nombre total d'images dans le document
void print_indentation() {
    for (int i = 0; i < count * 2; ++i) { // 2 spaces per indentation level
        printf(" ");
    }
}
%}

%union {
    char* str;
}

%token <str> NOM_DOC CHAINE NOM_IMAGE
%token DEBUT_DOC FIN_DOCUMENT FIN_BALISE VERSION_DOC DATE_DOC TITRE IMAGE DEBUT_SECTION FIN_SECTION COMMENTAIRE DATE NUM_VERSION
%start document

%%

document : DEBUT_DOC NOM_DOC FIN_BALISE VERSION_DOC NUM_VERSION FIN_BALISE DATE_DOC DATE FIN_BALISE TITRE CHAINE FIN_BALISE content FIN_DOCUMENT 
    {
        printf("Le document contient %d images\n", total_images);
    }
    ;

content  : section content | /* vide */
    ;

section : DEBUT_SECTION CHAINE FIN_BALISE 
    {
        count++;
        image_count = 0; // Réinitialiser le compteur d'images pour la nouvelle section
        print_indentation();
        printf("%d %s\n", count, $2);
    }
    comment element
    {
        print_indentation();
        printf("%d images\n", image_count); // Imprimer le nombre d'images pour cette section
        count--;
    }
    FIN_SECTION
    ;

element  : content | image_element ;

image_element : IMAGE NOM_IMAGE FIN_BALISE 
    {
        image_count++;
        total_images++;
        print_indentation();
        printf("%d %s\n", count, $2);
    }
    ;

comment  : COMMENTAIRE | /* vide */
    ;

%%

#include "lex.yy.c"

int main() {
    yyparse(); 
    return 0;
}
