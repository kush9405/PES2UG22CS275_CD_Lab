% {
#define YYSTYPE char*
#include "parser.tab.h"
#include <stdio.h>
extern void yyerror (const char *); // declare the error handling function
%}
/* Regular definitions */
digit   [0-9]
letter      [a-zA-Z]
id      {letter} ({letter}|{digit})*
digits      {digit}+
opFraction      (\- {digits})?
opExponent      ([Ee][+-]?{digits})?
number      {digits}{opFraction}{opExponent}
%Start comment
%option yylineno
%%
\/\/(.*);
"/*"
<comment>"*"+
‹comment> [^*\n]+
‹comment > \n
< comment>"*/"
< comment ><<EOF>>
// ignore comments
i BEGIN(comment); }
{ BEGIN( INITIAL); }
i printf("Unclosed comment\n"); exit(1);)
[\t\n] ;
"int"
"char"
"double"
"float"
"while"
"if"
"else"
"do"
"for"
"++"
"_-"
^\#include[^\n]*
"main"
// ignore whitespaces
& return T_INT; }
f return T_CHAR; }
{ return T_DOUBLE; }
{ return T_FLOAT; }
i return T_WHILE; }
{ return T_IF; }
i return T_ELSE; }
{ return T_DO; }
i return T_FOR; }
i return T_INC; }
i return T_DEC; }
{ return T_MAIN; }
{ yylval=strdup(yytext); return T_STRLITERAL; }