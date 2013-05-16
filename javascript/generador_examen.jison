/* Analizador Léxico */

%lex

%%

\s+                  /* ignoramos espacios en blanco */
\#\#\w+                { return 'TAG'; }
\#\!                   { return 'TAG_WRONG'; }
\#\=                   { return 'TAG_RIGHT'; }
\"(\\.|[^"])*?\"       { return 'TEXT'; }

/lex



%start S

%%

/* Gramática del lenguaje */

S : TITULO DESCRIPCION CONTENIDO { 
  
                                   var aux = CABECERA_FORMULARIO;
				   aux += "&lt;form name='examen' action='&lt;?php $_SERVER[#PHP_SELF#]; ?&gt;' method='post'&gt;";
				   aux = aux.replace(/'/g, "\"");
				   aux = aux.replace(/\#/g,"'");
				   aux += NEXT_LINE;
				   contadorPreguntas = 1;
				   return $1 + $2 + aux + $3 + END_WEB;  
                                  
                                 }

  ;

TITULO : 'TAG' 'TEXT' { $$ =  (MENOR + "title" + MAYOR + $2.replace(/\"/g,"") + MENOR + "/title" + MAYOR + NEXT_LINE); }

       ;

DESCRIPCION : 'TAG' 'TEXT' { $$ = $2.replace(/\"/g,"") + NEXT_LINE; }

            ;

CONTENIDO : 
            VERDADEROFALSO CONTENIDO { $$ = ($1 + $2); }
          | /* empty */ { $$ = ""; }

          ;

VERDADEROFALSO : 'TAG' 'TEXT' RESPUESTAS { $$ = (P + $2.replace(/\"/g,"") + END_P + NEXT_LINE + $3 + NEXT_LINE); contadorPreguntas++; }

               ;

RESPUESTAS :  
             'TAG_RIGHT' 'TEXT' RESPUESTAS { $$ = INPUT + contadorPreguntas + "' " + "value='" + TRUE + "'/" + MAYOR + $2.replace(/\"/g,"") + NEXT_LINE + $3; }
           | 'TAG_WRONG' 'TEXT' RESPUESTAS { $$ = INPUT + contadorPreguntas + "' " + "value='" + FALSE + "'/" + MAYOR + $2.replace(/\"/g,"") + NEXT_LINE + $3; }
           | /* empty */ { $$ = ""; }

           ;
	       
%%

var MENOR = "&lt;";
var MAYOR = "&gt;";
var NEXT_LINE = "\n";
var CABECERA_FORMULARIO = "&lt;! -- Formulario --&gt;" + NEXT_LINE + "&lt;h3&gt;PREGUNTAS&lt;/h3&gt;" + NEXT_LINE;
var P = MENOR + "p" + MAYOR;
var END_P = MENOR + "/p" + MAYOR;
var INPUT = MENOR + "input type='radio' name='respuesta_";
var contadorPreguntas = 1;
var TRUE = "true";
var FALSE = "false";
var END_WEB = "&lt;p&gt;&lt;input type='submit' name='evaluar' value='true' /&gt;&lt;/p&gt;"
             + NEXT_LINE + "&lt;/form&gt;" + NEXT_LINE + "&lt;/body&gt;" + NEXT_LINE + "&lt;/html&gt;";