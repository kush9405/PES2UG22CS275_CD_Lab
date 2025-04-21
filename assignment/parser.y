%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror(const char*);
    int yylex();
    extern int yylineno;
    extern char* yytext;
    int err = 0;
%}

%nonassoc LOWER_THAN_ELSE
%nonassoc T_ELSE
%token T_INT T_CHAR T_DOUBLE T_WHILE T_INC T_DEC T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL 
%token T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_NUM T_ID T_PRINTLN T_STRING 
%token T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_FOR
%token T_CHARLITERAL

/* Define operator precedence */
%right '='
%left T_OROR
%left T_ANDAND
%left T_EQCOMP T_NOTEQUAL
%left '<' '>' T_LESSEREQ T_GREATEREQ
%left '+' '-'
%left '*' '/'
%right '!' T_INC T_DEC  /* Unary operators */

%start START

%%
START : PROG { if(err==0) {printf("Valid syntax\n"); YYACCEPT;} }
    ;
    
PROG : T_INCLUDE '<' T_HEADER '>' PROG
    | MAIN PROG
    | DECLR ';' PROG             
    | ASSGN ';' PROG             
    | error ';' PROG             
    |                     
    ;
     
DECLR : TYPE LISTVAR
    | TYPE LISTVAR '=' EXPR
    ;

LISTVAR : LISTVAR ',' T_ID 
    | LISTVAR ',' T_ID '=' EXPR
    | T_ID
    | T_ID '[' T_NUM ']'
    | T_ID '=' EXPR
    ;
    
TYPE : T_INT
    | T_FLOAT
    | T_DOUBLE
    | T_CHAR
    ;
    
ASSGN : T_ID '=' EXPR 
    | T_ID '[' EXPR ']' '=' EXPR
    ;

EXPR : EXPR T_OROR EXPR          /* Logical OR */
    | EXPR T_ANDAND EXPR         /* Logical AND */
    | '!' EXPR                   /* Logical NOT */
    | EXPR REL_OP EXPR          /* Relational operations */
    | E
    ;
    
E : E '+' T
    | E '-' T
    | T
    ;
    
T : T '*' F
    | T '/' F
    | F
    ;

F : '(' EXPR ')'
    | T_ID
    | T_NUM
    | T_CHARLITERAL
    | T_ID T_INC
    | T_ID T_DEC
    | T_INC T_ID
    | T_DEC T_ID
    ;

REL_OP : T_LESSEREQ
    | T_GREATEREQ
    | '<' 
    | '>' 
    | T_EQCOMP
    | T_NOTEQUAL
    ;    
    
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' STMT '}';

EMPTY_LISTVAR : LISTVAR
    |    
    ;

STMT : STMT_NO_BLOCK STMT
    | BLOCK STMT
    |
    ;

STMT_NO_BLOCK : DECLR ';'
    | ASSGN ';'
    | WHILE_STMT
    | IF_STMT
    | FOR_STMT
    | DO_WHILE_STMT ';'
    | error ';'
    ;

BLOCK : '{' STMT '}';

WHILE_STMT : T_WHILE '(' EXPR ')' BLOCK
    | T_WHILE '(' EXPR ')' STMT_NO_BLOCK
    ;

IF_STMT : T_IF '(' EXPR ')' BLOCK %prec LOWER_THAN_ELSE
    | T_IF '(' EXPR ')' STMT_NO_BLOCK %prec LOWER_THAN_ELSE
    | T_IF '(' EXPR ')' BLOCK T_ELSE BLOCK
    | T_IF '(' EXPR ')' STMT_NO_BLOCK T_ELSE BLOCK
    | T_IF '(' EXPR ')' BLOCK T_ELSE STMT_NO_BLOCK
    | T_IF '(' EXPR ')' STMT_NO_BLOCK T_ELSE STMT_NO_BLOCK
    ;

FOR_STMT : T_FOR '(' FOR_INIT ';' EXPR ';' FOR_UPDATE ')' BLOCK
    | T_FOR '(' FOR_INIT ';' EXPR ';' FOR_UPDATE ')' STMT_NO_BLOCK
    ;

FOR_INIT : DECLR | ASSGN | /* empty */;
FOR_UPDATE : ASSGN | T_INC T_ID | T_DEC T_ID | /* empty */;

DO_WHILE_STMT : T_DO BLOCK T_WHILE '(' EXPR ')'
    | T_DO STMT_NO_BLOCK T_WHILE '(' EXPR ')'
    ;
       
%%
void yyerror(const char* s)
{
    printf("Error: %s,line number: %d,token: %s\n",s,yylineno,yytext);
    err = 1;
}

int yywrap()
{ 
    return(1); 
}

int main(int argc, char* argv[])
{
    yyparse();
    return 0;
}