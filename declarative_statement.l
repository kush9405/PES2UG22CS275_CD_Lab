%{
#include "declarative_statement.tab.h"
#include <stdio.h>
#include <string.h>  /* Required for strcpy */

extern int yylval;   /* Declare yylval as an external integer */
%}

%%
"["                   { printf("OBRACK: [\n"); return OBRACK; }
"]"                   { printf("CBRACK: ]\n"); return CBRACK; }
"int"[ ]+           { printf("KEY: int\n"); return KEY; }
"float"[ ]+         { printf("KEY: float\n"); return KEY; }
"double"[ ]+        { printf("KEY: double\n"); return KEY; }
"long int"[ ]+      { printf("KEY: long int\n"); return KEY; }
"char"[ ]+          { printf("KEY: char\n"); return KEY; }
"short"[ ]+         { printf("KEY: short\n"); return KEY; }
"long double"[ ]+    { printf("KEY: long double\n"); return KEY; }
[0-9]+               {
                        printf("NUMBER: %s\n", yytext);
                        yylval = atoi(yytext); /* Convert to integer */
                        return NUMBER;
                       }
[a-zA-Z_][a-zA-Z0-9_]*  {  /* Corrected ID rule */
                        printf("ID: %s\n", yytext);
                        yylval = 0; /* In a real parser, you'd copy yytext */
                        return ID;
                       }
[,]                  { printf("COMMA: ,\n"); return COMMA;}
[\t ]                ; /* Ignore whitespace */
[;]                  { printf("COLON: ;\n"); return COLON; }
[\n]                 { return 0; } /* Stop on newline */
.                    { printf("ERROR: Unknown character: %s\n", yytext); return yytext[0]; }
%%

int yywrap() {
    return 1;
}