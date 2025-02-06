%{
#include "c_parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylval;
%}

%%

"int"|"float" {
                if (strcmp(yytext, "int") == 0) {
                    yylval = TYPE_INT;
                    return TYPE;
                } else {
                    yylval = TYPE_FLOAT;
                    return TYPE;
                }
              }

"if"  { return IF; }
"else"{ return ELSE; } /* Added ELSE */
"while" { return WHILE; } /* Added WHILE */
"for" { return FOR; } /* Added FOR */

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval = strdup(yytext); /* Store identifier name */
    return ID;
}


[0-9]+(\.[0-9]+)? { /* Integer or Floating-point number */
    yylval = strdup(yytext);  /* Store number as string */
    return NUMBER;
}

"="   { return ASSIGN; }
"+"   { return PLUS; }
"-"   { return MINUS; }
"*"   { return TIMES; }
"/"   { return DIVIDE; }
"("   { return LPAREN; }
")"   { return RPAREN; }
"{"   { return LBRACE; }
"}"   { return RBRACE; }
";"   { return SEMICOLON; }
","   { return COMMA; }
"=="  { return EQ; }
"!="  { return NEQ; }
"<"   { return LT; }
">"   { return GT; }
"<="  { return LEQ; }
">="  { return GEQ; }
"!"   { return NOT; }

[ \t]   ;  /* Ignore whitespace */
\n      { return EOL; }  /* End of Line */
.       { printf("Lexer: Invalid character: %s\n", yytext); exit(1); } /* Error */
%%

int yywrap() {
    return 1;
}