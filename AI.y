%{
#include <string>
void yyerror(std::string s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <iostream>
#include <fstream>
void updatelist(std::string s1);

%}


%union {
 std::string *str;
 char var;
 char* chp;
}

%token <var>  OPENP CLOSEP  ENDP 
%token <str>  TXT TAG
%type <str>  tags


%%

tags:          OPENP tag_n ENDP sec CLOSEP tag_n ENDP {;} 
 	       | TXT                        {updatelist(*$1);};
                 
sec: 	       sec tags 
               | tags;
tag_n:         TAG;      //{updatelist(*$1);};   // Tag_name  

%%

void updatelist(std::string s1){

std::ofstream outf;
outf.open("tags.txt",std::ios::app);
outf << s1+"." << std::endl;
outf.close();

}

// To relate code with the tag name and point to code when an exception occurs








