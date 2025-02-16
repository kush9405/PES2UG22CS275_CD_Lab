#ifndef SYM_TAB_H
#define SYM_TAB_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct symbol {
    char* name;
    int size;
    int type;
    int line;
    int scope;
    char* val;
    struct symbol* next;
} symbol;

typedef struct table {
    symbol* head;
} table;

extern table* t;

table* init_table();
symbol* init_symbol(char* name, int size, int type, int lineno, int scope);
void insert_symbol(char* name, int size, int type, int lineno, int scope);
void insert_val(char* name, char* v, int line);
int check_sym_tab(char* name);
void display_sym_tab();
int size(int type);

#endif // SYM_TAB_H