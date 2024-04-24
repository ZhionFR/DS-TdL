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
int compteur = 6;

%}

noQuote [^\"]

%%

"<DOCUMENT" {
    return(DEBUT_DOC);
    isBalise = 1;
    isDocName = 1;
}
"<VERSION" {
    return(DEBUT_VERSION);
    isBalise = 1;
    isVersion = 1;
}
"<DATE" {
    return(DEBUT_DATE);
    isDate = 1;
}
"<TITRE" {
    return(DEBUT_TITRE);
    isBalise = 1;
    isTitle = 1;
}
"<SECTION" {
    return(DEBUT_SECTION);
    isBalise = 0;
    isSection = 1;
}
"</SECTION>" {
    return(FIN_SECTION);
    isBalise = 1;
}
"<IMAGE" {
    return(DEBUT_IMAGE);
    isBalise = 1;
    isImage = 1;
}
">" {
    if (isBalise){
        return(FIN_BALISE);
        isBalise = 1;
    }
}
"</DOCUMENT>" {
    return(FIN_DOC);
}

[[:alnum:]]+\.(jpg|jpeg|gif) {
    if (isImage){
        return(IMAGE);
        isImage = 0;
    }
}
[[:digit:]]{2,3}(\.[[:digit:]]{2,3}){2} { 
    if (isVersion){
        return(NUM_VERSION);
        isVersion = 0;
    }
}
[[:digit:]]{4}(\-[[:digit:]]{2}){2} {
   if (isDate){
        return(DATE);
        isDate = 0;
    }
}
\"{noQuote}*(\"{noQuote}\")*\" {
   if (isTitle){
        return(TITRE);
        isTitle = 0;
   }else{
        if (isSection){
            return(SECTION);
            isSection = 0;
        }
   }
}
[[:alnum:]]+(\.[[:alnum:]]+)* {
    if (isDocName){
        return(NOM_DOC);
        isDocName = 0;
    }
}
"/*"([^*]|"*"+[^*/])*"*"+"/" {
    return(CHAINE);
}


[\n] {
    /* Ignorer les \n */
}
[ \t] {
    /* Ignorer les espaces et tabulations */
}
