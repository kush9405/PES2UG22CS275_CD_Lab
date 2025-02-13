#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

typedef struct Entry {
    char name[50];
    char type[50];
    char scope[50];
    struct Entry* next;
} Entry;

typedef struct symbol {
    char name[50];   // Variable name
    int size;        // Size of the variable
    int type;        // Data type (can be an enum for int, float, etc.)
    int lineno;      // Line number where it was declared
    int scope;       // Scope level
    char value[50];  // Value of the symbol
    struct symbol* next; // Pointer to the next symbol in the linked list
} symbol;

// Define the structure for the symbol table
typedef struct {
    Entry* head; // Pointer to the first entry in the table
} table;

// Function to initialize the symbol table
table* init_table() {
    // Allocate space for the table structure
    table* t = (table*)malloc(sizeof(table));
    if (!t) {
        printf("Error: Memory allocation failed for symbol table\n");
        exit(1);
    }

    // Initialize the head pointer to NULL
    t->head = NULL;

    // Return the initialized table structure
    return t;
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) {
    // Allocate space for the symbol structure
    symbol* s = (symbol*)malloc(sizeof(symbol));
    if (!s) {
        printf("Error: Memory allocation failed for symbol entry\n");
        exit(1);
    }

    // Initialize struct variables
    strcpy(s->name, name);  // Copy name
    s->size = size;         // Assign size
    s->type = type;         // Assign type
    s->lineno = lineno;     // Assign line number
    s->scope = scope;       // Assign scope
    s->next = NULL;         // Initialize next pointer as NULL

    return s; // Return the initialized symbol structure
}

void insert_into_table(table* sym_table, symbol* new_symbol) {
    if (!sym_table) {
        printf("Error: Symbol table is not initialized.\n");
        return;
    }

    if (!new_symbol) {
        printf("Error: Cannot insert a NULL symbol.\n");
        return;
    }

    if (sym_table->head == NULL) {
        sym_table->head = new_symbol;  // Insert at the head if table is empty
    } else {
        symbol* temp = sym_table->head;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = new_symbol;  // Insert at the end of the list
    }
}

// Overloaded function to handle raw variables
void insert_into_table_from_values(table* sym_table, char* name, int size, int type, int lineno, int scope) {
    symbol* new_symbol = init_symbol(name, size, type, lineno, scope);
    insert_into_table(sym_table, new_symbol);
}

int check_symbol_table(table* sym_table, char* name) {
    if (!sym_table || !sym_table->head) {
        return 0; // Table is empty
    }

    symbol* temp = sym_table->head;
    while (temp) {
        if (strcmp(temp->name, name) == 0) {
            return 1; // Symbol found
        }
        temp = temp->next;
    }
    return 0; // Symbol not found
}

// Function to insert a value into an existing symbol entry
void insert_value_to_name(table* sym_table, char* name, char* value) {
    if (!sym_table || !sym_table->head) {
        printf("Error: Symbol table is empty.\n");
        return;
    }

    if (strcmp(value, "") == 0) { // Default value check
        printf("Error: Default value cannot be assigned.\n");
        return;
    }

    symbol* temp = sym_table->head;
    while (temp) {
        if (strcmp(temp->name, name) == 0) {
            strcpy(temp->value, value); // Assign the value
            return;
        }
        temp = temp->next;
    }
    
    printf("Error: Symbol '%s' not found in table.\n", name);
}

// Function to display the symbol table
void display_symbol_table(table* sym_table) {
    if (!sym_table || !sym_table->head) {
        printf("Symbol table is empty.\n");
        return;
    }

    printf("\n%-10s %-6s %-6s %-8s %-6s %-10s\n", "Name", "Size", "Type", "Line No", "Scope", "Value");
    printf("---------------------------------------------------------\n");

    symbol* temp = sym_table->head;
    while (temp) {
        printf("%-10s %-6d %-6d %-8d %-6d %-10s\n", temp->name, temp->size, temp->type, temp->lineno, temp->scope, temp->value[0] ? temp->value : "N/A");
        temp = temp->next;
    }
}