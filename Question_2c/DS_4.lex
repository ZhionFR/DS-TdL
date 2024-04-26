X       [a-zA-Z .']*
nom_titre   ["]{X}["]

nom_section (["][a-zA-Z .'"]*["])*

%%


"<VERSION " {
    return(DEBUT_VERSION);
}
"<IMAGE " {
    return(DEBUT_IMAGE);
}
"<DOCUMENT " {
    return(DEBUT_DOC);
}
"<TITRE " {
    return(DEBUT_TITRE);
}
"<SECTION " {
    return(DEBUT_SECTION);
}
"<DATE " {
    return(DEBUT_DATE);
}
">" {
    return(FIN_BALISE);
}
"</SECTION>" {
    return(FIN_SECTION);
}
"</DOCUMENT>" {
    return(FIN_DOC);
}

[[:digit:]]{2,3}(\.[[:digit:]]{2,3}){2} {
    return(NUM_VERSION);
}
[[:alnum:]]+\.(jpg|jpeg|gif) {
    yylval.str = strdup(yytext);
    return(IMAGE);
}
[[:alnum:]]+(\.[[:alnum:]]+)* {
    return(NOM_DOC);
}
[[:digit:]]{4}(\-[[:digit:]]{2}){2} {
    return(DATE);
}
{nom_titre} {
    /*return(TITRE_NOM);*/
    yylval.str = strdup(yytext);
    return(TITRESECTION);
}
{nom_section} {
    //return(NOM_SECTION);
    yylval.str = strdup(yytext);
    return(TITRESECTION);
}
"/*"([^*]|"*"+[^*/])*"*"+"/" {
    yylval.str = strdup(yytext);
    return(CHAINE);
}

[ \t\n] {
    /*espace, saut ligne, tabulation*/
} 

%%

/* hmmm */