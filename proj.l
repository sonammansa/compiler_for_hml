%{
#include <stdio.h>
#include<stdlib.h>
#include "y.tab.h"
#include<string.h>

%}
%%
"BEGIN"	{yylval.star = strdup(yytext);return begin;}
"END" 	{yylval.star = strdup(yytext);return end1;}
"AND" {yylval.star = strdup(yytext); return AND;}
"OR" {yylval.star = strdup(yytext); return OR;}
"BILL" {yylval.star = strdup(yytext);return bill;}
"BILLFIELD" {yylval.star = strdup(yytext);return billfield;}
"BOOK" {yylval.star = strdup(yytext);return book;}
"VIEW" {yylval.star = strdup(yytext);return view;}
"REMOVEITEM" {yylval.star = strdup(yytext);return removeitem;}
"REMOVE_TABLE" {yylval.star = strdup(yytext);return remove_table;}
['{']	return('{');
['}']	return('}');
[':']	return(':');
['(']	return('(');
[')']	return(')');
[';']   return(';');
":=" {yylval.star = strdup(yytext);return equal;}
"==" {yylval.star = strdup(yytext);return relop;}
"<=" {yylval.star = strdup(yytext);return relop;}
">=" {yylval.star = strdup(yytext);return relop;}
"<" {yylval.star = strdup(yytext);return relop;}
">" {yylval.star = strdup(yytext);return relop;}
"ADD_TABLE" {yylval.star = strdup(yytext);return add_table;}
[','] return(',');
"INT" {yylval.star = strdup(yytext);return datatype;}
"FLOAT" {yylval.star = strdup(yytext);return datatype;}
"CHAR" {yylval.star = strdup(yytext);return datatype;}	
"STRING" {yylval.star = strdup(yytext);return datatype;}
"BOOLEAN" {yylval.star = strdup(yytext);return datatype;}
"DATE" 	{yylval.star = strdup(yytext);return datatype;}
"ADDITEM" {yylval.star = strdup(yytext);return additem;}
"INTO" {yylval.star = strdup(yytext);return into;}
"true" {yylval.star = strdup(yytext);return val;}
"false" {yylval.star = strdup(yytext);return val;}
"MODIFY" {yylval.star = strdup(yytext);return modify;}
"SET" {yylval.star = strdup(yytext);return set;}
"WHERE" {yylval.star = strdup(yytext);return where;}
"CHECK" {yylval.star = strdup(yytext);return check;}
[a-zA-Z]* {yylval.star = strdup(yytext);return(variable);}
[a-zA-Z]*+["_"]+[a-zA-Z]* {yylval.star = strdup(yytext); return(tablename);}
    


[a-zA-Z]+[0-9]* {yylval.star = strdup(yytext);return roomno;}
[0-9]*	{yylval.star = strdup(yytext);return val;}

%%
int yywrap()
{ return 0;}
