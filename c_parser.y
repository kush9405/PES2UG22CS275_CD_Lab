%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

/* Token Declarations */
%token <str> ID NUMBER CHAR_LITERAL
%token <type>  TYPE  /* TYPE now has a type associated with it */
%token MAIN ASSIGN PLUS MINUS TIMES DIVIDE LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA EOL
%token IF ELSE WHILE FOR EQ NEQ LT GT LEQ GEQ NOT /* Added ELSE, WHILE, FOR */

/* Define token types for yylval */
%union {
    char *str;  /* For ID, NUMBER, CHAR_LITERAL */
    int type;   /* For TYPE (int, float, char, double) */
}

/* Non-terminal Type Definitions */
%type <str> Program Beginning Statement Declaration Assignment Condition Block Loop Expression Term Factor listVar X RelOp SimpleStatement CompoundStatement

/* Precedence and Associativity */
%nonassoc lower_than_else  /* Define a precedence level name, lower than ELSE */
%left ELSE
%left ASSIGN
%left EQ NEQ LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT

%%

/* Grammar Rules */
Program: MAIN LPAREN RPAREN Block { printf("Valid Program.\n"); }
       ;

Beginning:  Statement Beginning
        |   /* Empty */
        ;

Statement:  SimpleStatement
        |   CompoundStatement
        ;

SimpleStatement: Declaration SEMICOLON       { printf("Declaration.\n"); }
        |   Assignment SEMICOLON        { printf("Assignment statement.\n"); }
        |   Condition             { printf("Condition.\n"); }
        |   Loop                        { printf("Loop.\n"); }
        |   SEMICOLON                   { /* Empty Statement - just a semicolon */ }
        ;

CompoundStatement: Block               { printf("Compound Statement (Block).\n"); }
                  ;

Declaration:    Type listVar   { printf("Valid Declaration of type.\n"); }
       ;

Type:  TYPE      { printf("Type: %d, ", $1); $$ = $1; }
       ;

listVar:    ID X         { printf("listVar: %s\n", $1); free($1); }
       ;

X:          COMMA ID      { $$ = NULL; }
       |                /* empty */
                          { $$ = NULL; }
       ;

Assignment: ID ASSIGN Expression     { printf("Assignment statement.\n"); free($1); }
       ;

Condition:  IF LPAREN Expression RPAREN SimpleStatement                             { printf("IF statement (simple).\n"); }
        |   IF LPAREN Expression RPAREN SimpleStatement ELSE Statement %prec lower_than_else { printf("IF-ELSE statement (simple/statement).\n"); } /* Dangling ELSE resolution */
        |   IF LPAREN Expression RPAREN CompoundStatement                             { printf("IF statement with block.\n"); } /* Allow block after IF */
        |   IF LPAREN Expression RPAREN CompoundStatement ELSE CompoundStatement                    { printf("IF-ELSE statement with blocks.\n"); } /* Allow block after IF-ELSE */
        |   IF LPAREN Expression RPAREN CompoundStatement ELSE SimpleStatement          { printf("IF-ELSE statement with block/simple.\n"); } /* Allow block after IF-ELSE */
        ;

RelOp: EQ | NEQ | LT | GT | LEQ | GEQ ; /* RelOp is now only used in Expression */

Loop:   WHILE LPAREN Expression RPAREN SimpleStatement                            { printf("WHILE loop (simple).\n"); }
        |   WHILE LPAREN Expression RPAREN CompoundStatement                            { printf("WHILE loop with block.\n"); } /* Allow block for WHILE */
        |   FOR LPAREN Assignment SEMICOLON Expression SEMICOLON Assignment RPAREN SimpleStatement  { printf("FOR loop (simple).\n"); }
        |   FOR LPAREN Assignment SEMICOLON Expression SEMICOLON Assignment RPAREN CompoundStatement      { printf("FOR loop with block.\n"); } /* Allow block for FOR */
        ;

Block:  LBRACE Beginning RBRACE       { printf("Block statement.\n"); }
       ;

Expression: Term                     { $$ = NULL; }
        |   Expression PLUS Term    { $$ = NULL; }
        |   Expression MINUS Term   { $$ = NULL; }
        |   Expression RelOp Expression { $$ = NULL; }
        ;

Term:   Factor                      { $$ = NULL; }
        |   Term TIMES Factor     { $$ = NULL; }
        |   Term DIVIDE Factor    { $$ = NULL; }
        |   Factor                  { $$ = NULL; }
        ;


Factor:  NUMBER                      { $$ = NULL; }
        | ID                          { $$ = NULL; }
        | LPAREN Expression RPAREN    { $$ = NULL; }
        | NOT Factor                  { $$ = NULL; }
        | CHAR_LITERAL              { $$ = NULL; }
        ;


%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int main() {
    printf("Enter C code (end with Ctrl+D):\n");
    yyparse();
    return 0;
}