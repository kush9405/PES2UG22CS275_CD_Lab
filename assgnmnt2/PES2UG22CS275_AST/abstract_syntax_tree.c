#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "abstract_syntax_tree.h"

expression_node* init_exp_node(char* val, expression_node* left, expression_node* right)
{
    // function to allocate memory for an AST node and set the left and right children of the nodes
    expression_node* node = (expression_node*)malloc(sizeof(expression_node));
    node->left = left;
    node->right = right;
    node->val = val;
    return node; // Return the allocated node
}

void helper(expression_node* exp_node)
{
    if (exp_node == NULL) 
		return;
    printf("%s ", exp_node->val);
    helper(exp_node->left);
    helper(exp_node->right);
}

void display_exp_tree(expression_node* exp_node)
{
    // traversing the AST in postorder and displaying the nodes
    helper(exp_node);
    printf("\n");
}
