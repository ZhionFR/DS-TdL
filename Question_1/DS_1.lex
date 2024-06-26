%{
#include <stdio.h>
#include <string.h>

int isBalise = 0;
int isDocName = 0;
int isVersion = 0;
int isDate = 0;
int isTitle = 0;
int isImage = 0;
int isSection = 0;

%}

noQuote [^\"]

%%

"<DOCUMENT" {
    printf("DEBUT_DOC ");
    isBalise = 1;
    isDocName = 1;
}
"<VERSION" {
    printf("DEBUT_VERSION ");
    isBalise = 1;
    isVersion = 1;
}
"<DATE" {
    printf("DEBUT_DATE ");
    isDate = 1;
}
"<TITRE" {
    printf("DEBUT_TITRE ");
    isBalise = 1;
    isTitle = 1;
}
"<SECTION" {
    printf("DEBUT_SECTION ");
    isBalise = 0;
    isSection = 1;
}
"</SECTION>" {
    printf("FIN_SECTION ");
    isBalise = 1;
}
"<IMAGE" {
    printf("DEBUT_IMAGE ");
    isBalise = 1;
    isImage = 1;
}
">" {
    if (isBalise){
        printf("FIN_BALISE ");
        isBalise = 1;
    }
}
"</DOCUMENT>" {
    printf("FIN_DOC");
}

[[:alnum:]]+\.(jpg|jpeg|gif) {
    if (isImage){
        printf("IMAGE ");
        isImage = 0;
    }
}
[[:digit:]]{2,3}(\.[[:digit:]]{2,3}){2} { 
    if (isVersion){
        printf("NUM_VERSION ");
        isVersion = 0;
    }
}
[[:digit:]]{4}(\-[[:digit:]]{2}){2} {
   if (isDate){
        printf("DATE ");
        isDate = 0;
    }
}
\"{noQuote}*(\"{noQuote}\")*\" {
   if (isTitle){
        printf("TITRE ");
        isTitle = 0;
   }else{
        if (isSection){
            printf("SECTION ");
            isSection = 0;
        }
   }
}
[[:alnum:]]+(\.[[:alnum:]]+)* {
    if (isDocName){
        printf("NOM_DOC ");
        isDocName = 0;
    }
}
"/*"([^*]|"*"+[^*/])*"*"+"/" {
    printf("CHAINE ");
}


[\n] {
    /* Ignorer les \n */
}
[ \t] {
    /* Ignorer les espaces et tabulations */
}

%%

/* hmmm */