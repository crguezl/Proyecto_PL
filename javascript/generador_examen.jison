/* Analizador Léxico */

%lex

%%

\s+                  /* ignoramos espacios en blanco */
\#\#\w+                { return 'TAG'; }
\"(\\.|[^"])*?\"     { return 'TEXT'; }


/lex



%start S

%%

/* Gramática del lenguaje */

S : TITULO DESCRIPCION CONTENIDO

  ;

TITULO : 'TAG' 'TEXT'

       ;

DESCRIPCION : 'TAG' 'TEXT'

            ;

CONTENIDO : 
            VERDADEROFALSO CONTENIDO
          | /* empty */

          ;

VERDADEROFALSO : 'TAG' 'TEXT' ;
