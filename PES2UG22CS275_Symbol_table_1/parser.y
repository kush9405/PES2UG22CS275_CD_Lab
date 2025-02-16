%{
	#include "sym_tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	
	int scope = 0;
	int type = -1;
	char* vval = "-";
	
	void yyerror(char* s); // Error handling function
	int yylex(); // Function performing lexical analysis
	extern int yylineno; // Track the line number

	// Define type values
	#define INT 1
	#define FLOAT 2
	#define DOUBLE 3
	#define CHAR 4

%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   
%token T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ 
%token T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  
%token T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL 
%token T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START

%%

START : PROG { printf("Valid syntax\n"); YYACCEPT; }	
        ;	

PROG :  MAIN PROG				
	| DECLR ';' PROG 				
	| ASSGN ';' PROG 			
	| 					
	;

DECLR : TYPE LISTVAR 
	;	

LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				if (check_sym_tab($1))
					yyerror($1);
				insert_symbol($1, size(type), type, yylineno, scope);
				insert_val($1, vval, yylineno);
			}
     | T_ID 		{
				if (check_sym_tab($1))
					yyerror($1);
				insert_symbol($1, size(type), type, yylineno, scope);
			}	 

// Assign type here to be returned to the declaration grammar
TYPE : T_INT    { type = INT; }
     | T_FLOAT  { type = FLOAT; }
     | T_DOUBLE { type = DOUBLE; }
     | T_CHAR   { type = CHAR; }
     ;

/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
				if (check_sym_tab($1))
					yyerror($1);
				insert_symbol($1, size(type), type, yylineno, scope);
				insert_val($1, vval, yylineno);
				vval = "-";  // Missing semicolon fixed
			}
	;

EXPR : EXPR REL_OP E
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
    | T_STRLITERAL 
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	

/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' STMT '}' ;

EMPTY_LISTVAR : LISTVAR
		|	
		;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;

STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       ;

BLOCK : '{' STMT '}' ;

COND : EXPR 
       | ASSGN
       ;

%%

/* Error handling function */
void yyerror(char* s)
{
	printf("Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char* argv[]) {
    t = init_table();  // Ensure table is initialized
    yyparse();
    display_sym_tab();
    return 0;
}