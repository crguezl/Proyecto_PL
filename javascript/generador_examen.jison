/* Analizador Léxico */

%lex

%%

\s+                  /* ignoramos espacios en blanco */
\#\#\w+                { return 'TAG'; }
\"(\\.|[^"])*?\"       { return 'TEXT'; }

/lex



%start S

%%

/* Gramática del lenguaje */

S : TITULO DESCRIPCION CONTENIDO { return $1 + $2 + $3;  }

  ;

TITULO : 'TAG' 'TEXT' { $$ =  (MENOR + "title" + MAYOR + $2.replace(/\"/g,"") + MENOR + "/title" + MAYOR + NEXT_LINE); }

       ;

DESCRIPCION : 'TAG' 'TEXT' { $$ = $2.replace(/\"/g,"") + NEXT_LINE; }

            ;

CONTENIDO : 
            VERDADEROFALSO CONTENIDO { $$ = CABECERA_FORMULARIO + ($1 + $2); }
          | /* empty */ { $$ = ""; }

          ;

VERDADEROFALSO : 'TAG' 'TEXT' { $$ = $2.replace(/\"/g,"") + NEXT_LINE; }

               ;
	       
%%

var MENOR = "&lt;";
var MAYOR = "&gt;";
var NEXT_LINE = "\n";
var CABECERA_FORMULARIO = "&lt;! -- Formulario --&gt;" + NEXT_LINE + "&lt;h3&gt;PREGUNTAS&lt;/h3&gt;" + NEXT_LINE;