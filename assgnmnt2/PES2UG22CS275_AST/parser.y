%{
    #include "abstract_syntax_tree.c"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror(char* s);
    int yylex();
    extern int yylineno;
%}

%union {
    char* text;
    expression_node* exp_node;
}

%token <text> T_ID T_NUM IF ELSE DO WHILE RELOP
%type <exp_node> E T F START ASSGN S C SEQ

%start START

%%

START : SEQ {
    display_exp_tree($1);
    printf("\nValid syntax\n");
    YYACCEPT;
};

SEQ : S SEQ { $$ = init_exp_node("seq", $1, $2); }
    | S     { $$ = $1; }
;

S : IF '(' C ')' '{' SEQ '}' ELSE '{' SEQ '}' {
        $$ = init_exp_node(strdup("if-else"), $3, init_exp_node("", $6, $10));
    }
  | IF '(' C ')' '{' SEQ '}' {
        $$ = init_exp_node(strdup("if"), $3, $6);
    }
  | DO '{' SEQ '}' WHILE '(' C ')' ';' {
        $$ = init_exp_node(strdup("do-while"), $7, $3);
    }
  | ASSGN { $$ = $1; }
;

C : F RELOP F {
    $$ = init_exp_node(strdup($2), $1, $3);
}
;

ASSGN : T_ID '=' E ';' {
    $$ = init_exp_node(strdup("="), init_exp_node(strdup($1), NULL, NULL), $3);
}
;

E : E '+' T { $$ = init_exp_node(strdup("+"), $1, $3); }
  | E '-' T { $$ = init_exp_node(strdup("-"), $1, $3); }
  | T       { $$ = $1; }
;

T : T '*' F { $$ = init_exp_node(strdup("*"), $1, $3); }
  | T '/' F { $$ = init_exp_node(strdup("/"), $1, $3); }
  | F       { $$ = $1; }
;

F : '(' E ')' { $$ = $2; }
  | T_ID      { $$ = init_exp_node(strdup($1), NULL, NULL); }
  | T_NUM     { $$ = init_exp_node(strdup($1), NULL, NULL); }
;

%%

void yyerror(char* s)
{
    printf("Error: %s at line %d\n", s, yylineno);
}

int yywrap() {
    return 1;
}

int main(int argc, char* argv[])
{
    printf("Preorder:\n");
    yyparse();
    return 0;
}
