%{
    #define YYSTYPE char*
    #include "y.tab.h"
    #include <stdio.h>
    #include <string.h>

    extern void yyerror(const char *);
%}

/* Regular definitions */
digit   [0-9]
letter  [a-zA-Z]
id      {letter}({letter}|{digit})*
digits  {digit}+
opFraction  (\.{digits})?
opExponent  ([Ee][+]?{digits})?
number  {digits}{opFraction}{opExponent}?

%option yylineno

%%
\/\/.*        ;   // Ignore comments
[\t\n ]       ;   // Ignore whitespace

"int"         { return T_INT; }
"char"        { return T_CHAR; }
"double"      { return T_DOUBLE; }
"float"       { return T_FLOAT; }
"while"       { return T_WHILE; }
"if"          { return T_IF; }
"else"        { return T_ELSE; }
"do"          { return T_DO; }
"#include"    { return T_INCLUDE; }
"main"        { return T_MAIN; }

\".*\"        { yylval = strdup(yytext); return T_STRLITERAL; }

"=="          { return T_EQCOMP; }
"!="          { return T_NOTEQUAL; }
">="          { return T_GREATEREQ; }
"<="          { return T_LESSEREQ; }

"("           { return '('; }
")"           { return ')'; }
"{"           { return '{'; }
"}"           { return '}'; }
"*"           { return '*'; }
"+"           { return '+'; }
";"           { return ';'; }
"-"           { return '-'; }
"/"           { return '/'; }
"="           { return '='; }
">"           { return '>'; }
"<"           { return '<'; }

{number}      { yylval = strdup(yytext); return T_NUM; }
{id}\.h       { return T_HEADER; }  // Header file name
{id}          { yylval = strdup(yytext); return T_ID; }
.             { return yytext[0]; }  // Handle unrecognized characters

%%

int yywrap() { return 1; }