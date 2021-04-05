%{ 
#include <stdio.h>
#include <string>
#include <iostream>
#include "y.tab.h"

void yyerror(std::string str);
int yyparse(void);
%}
%option yylineno

%%
[ \n\t\r]+     ;  // ignore whitespace


"<"            return OPENP;
[a-z0-9]*         {yylval.str=new std::string(yytext); return TAG;}
[a-zA-Z_0-9]*       {yylval.str= new std::string(yytext); return TXT;}
">"            return ENDP;
"</"           return CLOSEP;



.          {ECHO; yyerror("unexpected character");}  // error for any other character
                                             

%%

void yyerror(std::string str){
	std::cout << "Parse Error:" << str << " at line " << yylineno << std::endl;
}

int yywrap ( void ) {return 1;}

int main(int num_args, char** args){
	if (num_args !=2)
	{
		printf("usage: ./parser1 filename\n");
		exit(0);
	}
	FILE* file1 = fopen(args[1],"r");
	if (file1 == NULL)
	{
		printf("Cannot open %s\n",args[1]);
		exit(0);
	}
	yyin = file1;
	yyparse();
	fclose(file1);
}

