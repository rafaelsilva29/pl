%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

char *nomePrincipal,*eventos,*token;
int idP, idE;
FILE *fp;
int count=1;
extern int yylex();
extern int yylineno;
void yyerror(char *s);
%}

%union{int id;int ano; char *str;char c;}
%start NGen
%token exit_comm 
%token <id> identifier
%token <ano> nascimento nascimentoIncerto falecimento falecimentoIncerto casamento evento
%token <str> nome parentesco foto hist
%token <c> newline
%type <str> LINE PESSOAPRINCIPAL EVENTOS EVENTO PESSOA

%%

NGen			: LINE					{;}
				| NGen LINE				{;}
				;

LINE			: PESSOAPRINCIPAL		{;}
				| exit_comm				{fclose(fp); exit(EXIT_SUCCESS);}
				| newline 				{;}
				;

PESSOAPRINCIPAL	: nome EVENTOS '['identifier']' {
					if(strchr($1,'/')){
						char* tmp=strdup($1);
						char* token=strtok(tmp,"/");
						fprintf(fp,"#I%d nome %s ",$4,token);
						token=strtok(NULL,"/");
						fprintf(fp,"apelido %s\n",token);
					}else
						fprintf(fp,"#I%d nome %s\n",$4,$1);
					if(strchr($1,'%')){
						char* tmp=strdup($1);
						char* token2=strtok(tmp,"%");
						token2=strtok(NULL,"%");
						fprintf(fp,"Existem %s pessoas com este nome\n",token2);
					}
					eventos=malloc(sizeof(char)*strlen($2)+1);
					strcpy(eventos,$2);
					if(eventos){
						char * token=strtok(eventos,"$");
						while(token!=NULL){
							fprintf(fp, "#I%d %s\n",$4,token);
							token=strtok(NULL,"$");
						}
					}
				}
				;

EVENTOS 		: EVENTO 					{ $$=$1; }
				| EVENTOS EVENTO 			{ asprintf(&$$,"%s%s",$1,$2); }
				| EVENTOS newline EVENTO 	{ asprintf(&$$,"%s%s",$1,$3); }
				;

EVENTO		: nascimento 					{ asprintf(&$$,"$nasceu em %d",$1); }
			| falecimento 					{ asprintf(&$$,"$morreu em %d",$1); }
			| nascimentoIncerto 			{ asprintf(&$$,"$nasceu cerca de %d",$1); }
			| falecimentoIncerto			{ asprintf(&$$,"$morreu cerca de %d",$1); }
			| casamento PESSOA 				{ asprintf(&$$,"$casou em %d com #aut%d\n%s",$1,count++,$2); }
			| evento 						{ 
				char* tmp=strdup($1);
				char* token=strtok(tmp,":");
				token=strtok(NULL,":");
				asprintf(&$$,"$evento %s em %s\n",token,$1);
			}
			| parentesco PESSOA				{		
				if(!strcmp($1,"PP")) 		{ asprintf(&$$,"$pai-do-pai #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"MM")) 	{ asprintf(&$$,"$mae-da-mae #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"P")) 	{ asprintf(&$$,"$tem-como-pai #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"M")) 	{ asprintf(&$$,"$tem-como-mae #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"MP")) 	{ asprintf(&$$,"$mae-do-pai #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"PM")) 	{ asprintf(&$$,"$pai-da-mae #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"F"))	{ asprintf(&$$,"$tem-como-filho #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-PP"))	{ asprintf(&$$,"$neto(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-MM")) 	{ asprintf(&$$,"$neto(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-P")) 	{ asprintf(&$$,"$filho(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-M")) 	{ asprintf(&$$,"$filho(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-MP")) 	{ asprintf(&$$,"$neto(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-PM")) 	{ asprintf(&$$,"$neto(a) #aut%d\n%s",count++,$2); }
				else if(!strcmp($1,"-F"))	{ asprintf(&$$,"$pai/mae #aut%d\n%s",count++,$2); }
				else						{ printf("parentesco desconhecido"); }
			}
			| foto							{ asprintf(&$$,"$%s",$1); }
			| hist							{ asprintf(&$$,"$%s",$1); }
			;

PESSOA 		: nome '['identifier']'			{ asprintf(&$$,"#aut%d nome %s\n#aut%d id %d",count,$1,count,$3);}
			| nome EVENTO '['identifier']'	{ asprintf(&$$,"#aut%d nome %s\n#aut%d id %d\n#aut%d %s",count,$1,count,$4,count,$2);}
			;

%%

void yyerror(char *s){
	printf("erro: %s\nlinha %d",s,yylineno);
	exit(1);
}

int main(){
	fp=fopen("config.out","a");	
	while(1)
		yyparse();
	return 0;
}