%{
#include <stdio.h>
#include <string.h>

int isBalise;
char TEXT[15];
int compteur = 6;
%}

%%

"<DOCUMENT"               {
        printf("DEBUT_DOC "); isBalise = 1;
    }
[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*    {
        if (compteur == 6){
            printf("NOM_DOC ");
            compteur = 5;
        }
    }
"<VERSION"                {
        printf("DEBUT_VERSION NUM_VERSION "); isBalise = 1;
    }
nb{2,3}(.nb{2,3}){1,2}    {
        if (compteur==5){
            printf("NUM_VERSION ");
            compteur = 4;
        }
    }
"<DATE"                   {
        printf("DEBUT_DATE DATE ");
        isBalise = 1;
    }
"<TITRE"                  {
        printf("DEBUT_TITRE TITRE ");
        isBalise = 1;
    }
"<SECTION"                {
        printf("DEBUT_SECTION ");
        isBalise = 0;
    }
"</SECTION>"              {
        printf("FIN_SECTION ");
        isBalise = 1;
    }
"<IMAGE"                  {
        printf("DEBUT_IMAGE IMAGE ");
        isBalise = 1;
    }
">"                       {
        if (isBalise){
            printf("FIN_BALISE ");
            isBalise = 1;
        }
    }
"</DOCUMENT>"             {
        printf("FIN_DOC");
    }
[\n]                      {
        /* Ignorer les \n */
    }
[ \t]                     {
        /* Ignorer les espaces et tabulations */
    }
