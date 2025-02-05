%{
#include <stdio.h>
#include <stdlib.h> /* Required for exit() */

int flag = 0;
int yylex();
void yyerror(const char *s);
%}

%token ID KEY NUMBER COLON COMMA  OBRACK CBRACK
%%

stmt: list { printf("\nDeclaration is validated!!!\n"); exit(0); }
    ;

list: declaration COLON
    ;

declaration: KEY list_var
           | KEY ID OBRACK NUMBER CBRACK
           | array_error  /* Handle array errors more cleanly */
           ;

list_var:X
        | X COMMA list_var
        ;

X:ID
  ;  


array_error: ID OBRACK NUMBER '.' CBRACK   { printf("\nError!! Float value is not allowed as array size\n"); exit(0); }
           | ID OBRACK ID CBRACK        { printf("\nError!! Size of the array should be a number\n"); exit(0); }
           | ID OBRACK ID             { printf("\nError!! Closing Bracket should be given\n"); exit(0); }
           | ID OBRACK                 { printf("\nError!! Size of the array should be given\n"); exit(0); }
           ;


%%

int main() {
    printf("Enter a valid statement:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}