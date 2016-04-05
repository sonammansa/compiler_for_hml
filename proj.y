%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include "y.tab.h"

%}
%union {
int ival;
char *star;
struct s1
{ 	char value2[100]; 
	char type1[100];
}dec;
}
%token <star> add_table begin end1 additem into val equal modify set remove_table removeitem where AND OR relop bill billfield book roomno view check 
%token <star> variable
%token <star> datatype
%token <star> tablename
%type <dec> ARGLIST
%type <dec> ARGLIST2
%type <dec> ARGLIST3
%type <dec> ARG ST8
%type <star> ARG2
%type <dec> ARG3
%%
prog : begin '{' STMNT_LIST '}' end1 { printf("\nvalid string\n\n"); return;}
STMNT_LIST : STMNT ';' STMNT_LIST | STMNT ';' 
STMNT : ST1 | ST2 | ST3 | ST4 | ST5 | ST6 | ST7 | ST8 | ST9 
ST1 : add_table '{' tablename '}' '(' ARGLIST ')'{ printf("create table %s",$3); printf(" { %s; }\n",$6.type1);} 
ARGLIST : ARG ',' ARGLIST {strcat($$.type1," "); strcat($$.type1,$1.value2); strcat($$.type1," , ");strcat($$.type1,$3.type1); strcat($$.type1," ");}
          | ARG { strcat($$.type1," "); strcat($$.type1,$1.value2);} 
ARG : datatype variable { strcpy($$.type1,$1); strcpy($$.value2,$2);}
ST2 : additem into tablename '('  ARG2 ')' {printf("insert into %s values (",$3);printf("%s)\n",$5);}
ARG2 : val ',' ARG2           {strcat($$,",");strcat($$,$3);}
          | variable ',' ARG2  {strcat($$,",");strcat($$,$3);}
          | val        {strcpy($$,$1);}
          | variable   {strcpy($$,$1);}
ST3 : modify tablename set '(' ARGLIST2 ')' where ARGLIST3 {printf("update %s set(%s) where(%s)\n",$2,$5.type1,$8.type1);}
ARGLIST2 : ARG equal val ',' ARGLIST2 {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,":=");strcat($$.type1,$3);strcat($$.type1,",");strcat($$.type1,$5.type1);} 
          | ARG equal variable ',' ARGLIST2 {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,":=");strcat($$.type1,$3);strcat($$.type1,",");strcat($$.type1,$5.type1);}
          | ARG equal val {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,":=");strcat($$.type1,$3);}
          | ARG equal variable {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,":=");strcat($$.type1,$3);}
ST4 : remove_table tablename   {printf("droptable %s\n",$2);}
ST5 : removeitem tablename where ARGLIST3  {printf("delete from %s where(%s)\n",$2,$4.type1);}
ARGLIST3 : ARG3 AND ARGLIST3 {strcat($$.type1," ");strcat($$.type1,$2);strcat($$.type1," ");strcat($$.type1,$3.type1);}
          | ARG3 OR ARGLIST3 {strcat($$.type1," ");strcat($$.type1,$2);strcat($$.type1," ");strcat($$.type1,$3.type1);}
          | ARG3             {strcpy($$.type1," ");strcat($$.type1,$1.type1);}
ARG3 : ARG relop val {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,$2);strcat($$.type1,$3);}
       | ARG relop variable {strcat($$.type1," ");strcat($$.type1,$1.value2);strcat($$.type1,$2);strcat($$.type1,$3);}
ST6 : bill tablename billfield '(' ARGLIST3 ')'{printf("select %s from %s where(%s)",$3,$2,$5.type1);}
ST7 : book tablename '(' ARG2 ')' ':' roomno   {printf("insert into %s values(%s,%s)",$2,$4,$7);} 
ST8 : view tablename '(' ARGLIST ')' {printf("select %s from %s",$4.type1,$2); }           
ST9 : check tablename '(' ARGLIST ')' where ARGLIST3 {printf("select %s from %s where %s",$4.type1,$2,$4.type1);}
%%
int main()
{ yyparse();
return 0;
}
int yyerror() {
printf("\ninvalid string\n");
}
              
