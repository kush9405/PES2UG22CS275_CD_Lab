#ifndef SYM_TAB_H
#define SYM_TAB_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CHAR 1
#define INT 2
#define FLOAT 3
#define DOUBLE 4

// Data structure for symbol table entries
typedef struct symbol {
    char* name;      // Identifier name
    int size;        // Storage size of identifier
    int type;        // Identifier type
    char* val;       // Value of the identifier
    int line;        // Declared line number
    int scope;       // Scope of the variable
    struct symbol* next;
} symbol;

// Data structure for the symbol table
typedef struct table {
    symbol* head;  // Pointer to the first entry
} table;

// Global symbol table pointer
static table* t; 

// Function prototypes
table* allocate_space_for_table();  
// Allocates space for a new symbol table

symbol* allocate_space_for_table_entry(char* name, int size, int type, int lineno, int scope);  
// Allocates and initializes a new symbol table entry

void insert_into_table(table* sym_table, symbol* new_symbol);  
// Inserts an entry into the table

void insert_value_to_name(table* sym_table, char* name, char* value);  
// Inserts a value into an existing entry

int check_symbol_table(table* sym_table, char* name);  
// Checks if a symbol is already in the table (returns 1 if found, else 0)

void display_symbol_table(table* sym_table);  
// Displays the entire symbol table

#endif /* SYM_TAB_H */