//sym_tab.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table* t = NULL; // Define the global table pointer

table* init_table() { 
    t = (table*)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) //allocates space for items in the list
{
    symbol* s = (symbol*)malloc(sizeof(symbol));
    s->name=(char*)malloc(sizeof(char)*(strlen(name)+1));
    strcpy(s->name,name);
    s->size=size;
    s->type = type;
    s->line=lineno;
    s->scope=scope;
    s->val=(char*)malloc(sizeof(char)*10);
    strcpy(s->val,"-");
    s->next=NULL;
    return s;

}


void insert_symbol(char* name, int size, int type, int lineno, int scope) {
    if (t == NULL) { // Initialize if not already initialized
        t = init_table();
    }

    symbol* s = init_symbol(name, size, type, lineno, scope);
    if (t->head == NULL) {
        t->head = s;
        return;
    }

    symbol* curr = t->head;
    while (curr->next != NULL) {
        curr = curr->next;
    }
    curr->next = s;
}

void insert_val(char* name,char* v,int line){
    if (strcmp(v, "-") == 0)
        return;
    if(t->head==NULL)
    {
        return;
    }
    symbol* curr=t->head;
    while(curr!=NULL)
    {
        if(strcmp(curr->name,name)==0)
        {
            strcpy(curr->val,v);
            curr->line=line;
            return;
        }
        curr=curr->next;
    }
}

int check_sym_tab(char* name) {
    if (t == NULL || t->head == NULL) { // Prevent NULL dereference
        return 0;
    }

    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return 1;
        }
        curr = curr->next;
    }
    return 0;
}

void display_sym_tab(){
    symbol* curr=t->head;
    if(curr==NULL){
        return;
    }
    printf("NAME\tSIZE\tTYPE\tLINENO\tSCOPE\tVALUE\n");
    while(curr!=NULL)
    {
        printf("%s\t%d\t%d\t%d\t%d\t%s\n",curr->name,curr->size,curr->type,curr->line,curr->scope,curr->val);
        curr=curr->next;
    }
}
int size(int type)
{
    if(type==3)
        return 4;
    if(type==4)
        return 8;
    return type;
}