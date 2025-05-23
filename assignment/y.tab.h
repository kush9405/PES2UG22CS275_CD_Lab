/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     LOWER_THAN_ELSE = 258,
     T_ELSE = 259,
     T_INT = 260,
     T_CHAR = 261,
     T_DOUBLE = 262,
     T_WHILE = 263,
     T_INC = 264,
     T_DEC = 265,
     T_OROR = 266,
     T_ANDAND = 267,
     T_EQCOMP = 268,
     T_NOTEQUAL = 269,
     T_GREATEREQ = 270,
     T_LESSEREQ = 271,
     T_LEFTSHIFT = 272,
     T_RIGHTSHIFT = 273,
     T_NUM = 274,
     T_ID = 275,
     T_PRINTLN = 276,
     T_STRING = 277,
     T_FLOAT = 278,
     T_BOOLEAN = 279,
     T_IF = 280,
     T_STRLITERAL = 281,
     T_DO = 282,
     T_INCLUDE = 283,
     T_HEADER = 284,
     T_MAIN = 285,
     T_FOR = 286,
     T_CHARLITERAL = 287
   };
#endif
/* Tokens.  */
#define LOWER_THAN_ELSE 258
#define T_ELSE 259
#define T_INT 260
#define T_CHAR 261
#define T_DOUBLE 262
#define T_WHILE 263
#define T_INC 264
#define T_DEC 265
#define T_OROR 266
#define T_ANDAND 267
#define T_EQCOMP 268
#define T_NOTEQUAL 269
#define T_GREATEREQ 270
#define T_LESSEREQ 271
#define T_LEFTSHIFT 272
#define T_RIGHTSHIFT 273
#define T_NUM 274
#define T_ID 275
#define T_PRINTLN 276
#define T_STRING 277
#define T_FLOAT 278
#define T_BOOLEAN 279
#define T_IF 280
#define T_STRLITERAL 281
#define T_DO 282
#define T_INCLUDE 283
#define T_HEADER 284
#define T_MAIN 285
#define T_FOR 286
#define T_CHARLITERAL 287




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

