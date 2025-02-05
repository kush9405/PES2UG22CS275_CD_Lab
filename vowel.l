%{
#include <stdio.h>  /* Required for printf */
int vow_count = 0;
int conso_count = 0;
%}

%%
[aeiouAEIOU]   { vow_count++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z] { conso_count++; }
.               {/* Ignore other characters */}
\n              { return 0; /* Stop processing at newline */ }
%%

int main() {
    printf("Enter the string to analyze the number of vowels and consonants:\n");
    yylex();  /* Start the lexer */
    printf("Vowel Count: %d\n", vow_count);
    printf("Consonant Count: %d\n", conso_count);
    return 0;
}

int yywrap() {
    return 1;  /* No more input files */
}