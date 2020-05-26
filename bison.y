%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);

%}

%token EXP
%token INT
%token EOL
%token MUL
%token SOMA
%token DIV
%token PD
%token PE
%left SOMA
%left MUL
%left DIV
%left PE
%left EXP

%%

PROGRAMA:
        |PROGRAMA EXPRESSAO EOL { printf("Resultado: %d\n", $2); }
        ;


EXPRESSAO:
    | INT { $$ = $1; }
    | PE EXPRESSAO PD {
        $$ = $2;
        }

    | EXPRESSAO EXP EXPRESSAO   {
	for (int i=0 ; i<$3 -1 ; i++ ){
		$$ *= $1;
		}
	printf("Encontrei exponenciaca: %d ^ %d = %d\n",$1,$3,$1^$3);
	}
    | EXPRESSAO MUL EXPRESSAO   {
        printf("Encontrei multilicacao: %d * %d = %d\n",$1,$3,$1*$3);
        $$ = $1 * $3;
        }
    | EXPRESSAO DIV EXPRESSAO   {
        printf("Encontrei divisao: %d / %d = %d\n",$1,$3,$1/$3);
        $$ = $1 / $3;
        }

    | EXPRESSAO SOMA EXPRESSAO  {
        printf("Encontrei soma: %d + %d = %d\n", $1, $3, $1+$3);
        $$ = $1 + $3;
        }
   ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  yyparse();
  return 0;

}