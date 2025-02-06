%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror(char* s);
extern int yylineno;
extern char *yytext;
%}
%token INT FLOAT DOUBLE CHAR STATIC ID INCLUDE HEADER MAIN DO WHILE IF ELSE FOR BOOL BREAK INC DEC STRLIT VNUM LT GT GTE LTE EQ NE OR AND LNOT SCOMB ECOMB SSQB ESQB SCURB ECURB
%start P
%%


P : S {printf("Valid Syntax\n");YYACCEPT;}
  ;

S : INCLUDE HEADER S
  | STATIC S
  | MAINF
  | DECLR ';' S
  | ASSGN ';' S
  | /* epsilon */
  ;

TYPE : INT | FLOAT | CHAR | BOOL | DOUBLE
     ;

DECLR : TYPE List_Var
      | error
      ;

List_Var : List_Var ',' ID | ID
         ;

ASSGN : ID '=' EXPR  // Removed TYPE ID '=' EXPR and STRLIT from ASSGN to avoid potential conflict with DECLR in statement context. STRLIT assignment should be handled as EXPR if needed.
      | STRLIT         // Added STRLIT as a standalone ASSGN
      ;

EXPR : EXPR RELOP E
     | E
     | ID INC
     | ID DEC
     | LNOT EXPR // Apply LNOT to EXPR instead of just ID for broader usage.
     | ASSGN       // Allow ASSGN to be part of EXPR.
     ;

RELOP : GTE|LTE|EQ|NE|OR|AND|LT|GT
      ;

E : E '+' T
  | E '-' T
  | T
  ;

T : T '*' F
  | T '/' F
  | F
  ;


F : SCOMB EXPR ECOMB
  | ID
  | VNUM
  ;

MAINF : TYPE MAIN SCOMB /*Empty_ListVar*/ ECOMB SCURB Stmt_Block ECURB // Removed Empty_ListVar
     ;

/* Empty_ListVar : List_Var // Removed Empty_ListVar and its rule as it seems redundant
	      |
              ;*/

Stmt_Block : Stmt Stmt_Block
           | /* epsilon */
           ;

Stmt : SingleStmt
     | Block
     | BREAK ';' // BREAK is a statement and needs a semicolon
     ;

Ifelstmt : Stmt_Block // Ifelstmt now expects a block of statements.
	 ;


SingleStmt : DECLR ';'
           | ASSGN ';'
           | IF SCOMB COND ECOMB Ifelstmt
           | IF SCOMB COND ECOMB Ifelstmt ELSE Ifelstmt
           | LOOP
           | DO Block WHILE COND ';'
           ;

Block : SCURB Stmt_Block ECURB
      ;

LOOP : WHILE SCOMB COND ECOMB Stmt_Block // LOOP2 replaced with Stmt_Block for consistency
      | FOR SCOMB COND ECOMB Stmt_Block // LOOP2 replaced with Stmt_Block for consistency
      ;

COND : EXPR
     ;


%%
void yyerror(char* s)
{
printf("Error:%s,line number:%d,token:%s\n",s,yylineno,yytext);
}

int main()
{
yyparse();
return 0; // Added return 0 for main function best practice.
}