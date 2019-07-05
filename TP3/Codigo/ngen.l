%option noyywrap

%{
#include "y.tab.h"
%}

ano [0-9]{1,}

%%

"exit"								{return exit_comm;}
[0-9]+								{yylval.id=atoi(yytext);return identifier;}
(\-)?(PP|MM|PM|MP|P|M|F)			{yylval.str=strdup(yytext);return parentesco;}
cc\({ano}							{yylval.ano=atoi(yytext+3); return casamento;}
ev\({ano}							{yylval.str=strdup(yytext+3); return evento;}
[a-zA-Z]+(\/[a-zA-Z]+)?(\%[0-9]+)?	{yylval.str=strdup(yytext); return nome;}
\*{ano}								{yylval.ano=atoi(yytext+1); return nascimento;}
\*c{ano}							{yylval.ano=atoi(yytext+2); return nascimentoIncerto;}
\+{ano}								{yylval.ano=atoi(yytext+1); return falecimento;}
\+c{ano}							{yylval.ano=atoi(yytext+2); return falecimentoIncerto;}
.*\.jpg								{yylval.str=strdup(yytext); return foto;}
.*\.tex								{yylval.str=strdup(yytext); return hist;}
"\n"								{return newline;}
[\[\]]								{return yytext[0];}
.									{;}

%%