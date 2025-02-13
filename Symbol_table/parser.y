%{
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*

	// Variables to track identifier properties
	char currentType[50];   // Stores the current data type (int, float, etc.)
	char currentScope[50] = "global"; // Default scope (implementation in the next lab)

	// Function declarations
	void yyerror(char* s); // Error handling function
	int yylex(); // Lexical analyzer function
	extern int yylineno; // Tracks line numbers

%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START


%%
START : PROG { printf("Valid syntax\n"); YYACCEPT; }	
        ;	
	  
PROG :  MAIN PROG				
	|DECLR ';' PROG 				
	| ASSGN ';' PROG 			
	| 					
	;
	 

DECLR : TYPE LISTVAR 
	;	


LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: 
    T_ID '=' EXPR {
        /*
            To be done in Lab 3
        */
    }
    | T_ID {
        // Check if the identifier exists in the symbol table
        if (lookup($1)) {
            printf("Error: Variable '%s' redeclared at line %d\n", $1, yylineno);
        } else {
            // Insert new variable into the symbol table
            insert($1, currentType, currentScope);
            
            // Reset type variable after insertion
            strcpy(currentType, ""); 
        }
    } 

//assign type here to be returned to the declaration grammar
TYPE : T_INT 
       | T_FLOAT 
       | T_DOUBLE 
       | T_CHAR 
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
				/*
					to be done in lab 3
				*/
				if(!check_sym_tab($1))
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
       ;

BLOCK : '{' STMT '}';

COND : EXPR 
       | ASSGN
       ;


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


int main(int argc, char* argv[])
{
	/* initialise table here */
	yyparse();
	/* display final symbol table*/
	return 0;

}
