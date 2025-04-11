%{
    #define YYSTYPE char*
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>
    extern void yyerror(const char *);
%}

digit   [0-9]
letter  [a-zA-Z]
id      {letter}({letter}|{digit})*
digits  {digit}+
opFraction (\.{digits})?
opExponent ([Ee][+-]?{digits})?
number  {digits}{opFraction}{opExponent}

%option yylineno

%%

\/\/.*                     ;
[\t\n ]                    ;

"if"                       { return IF; }
"else"                     { return ELSE; }
"do"                       { return DO; }
"while"                    { return WHILE; }

"<="                       { yylval = strdup("<="); return RELOP; }
">="                       { yylval = strdup(">="); return RELOP; }
"=="                       { yylval = strdup("=="); return RELOP; }
"!="                       { yylval = strdup("!="); return RELOP; }
"<"                        { yylval = strdup("<"); return RELOP; }
">"                        { yylval = strdup(">"); return RELOP; }

"("                        { return *yytext; }
")"                        { return *yytext; }
"{"                        { return *yytext; }
"}"                        { return *yytext; }
"="                        { return *yytext; }
";"                        { return *yytext; }
"+"                        { return *yytext; }
"-"                        { return *yytext; }
"*"                        { return *yytext; }
"/"                        { return *yytext; }

{number}                   {
                             yylval = strdup(yytext);
                             return T_NUM;
                          }

{id}                       {
                             yylval = strdup(yytext);
                             return T_ID;
                          }

.                          ;  // ignore other characters
%% 
