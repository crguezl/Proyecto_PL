/* Analizador Léxico */

%lex

%%

\s+                  /* ignoramos espacios en blanco */
\#\#Title	       { return 'TAG_TITLE'; }
\#\#Descp	       { return 'TAG_DESCP'; }
\#\#TrueFalse	       { return 'TAG_TRUEFALSE'; }
\#\!                   { return 'TAG_WRONG'; }
\#\=                   { return 'TAG_RIGHT'; }
\"(\\.|[^"])*?\"       { return 'TEXT'; }

/lex



%start S

%%

/* Gramática del lenguaje */

S : TITULO DESCRIPCION CONTENIDO { 
  
                                   var aux = HEAD_FORM;
				   aux += "&lt;form name='examen' action='&lt;?php $_SERVER[#PHP_SELF#]; ?&gt;' method='post'&gt;";
				   aux = aux.replace(/'/g, "\"");
				   aux = aux.replace(/\#/g,"'");
				   aux += NEXT_LINE;
				   $2 = generarPHP($2);
				   respuestas = [];
				   aciertos = [];
				   return $1 + $2 + aux + $3 + END_WEB;  
                                  
                                 }

  ;

TITULO : 'TAG_TITLE' 'TEXT' { 
                              var titulo = $2.replace(/\"/g,"");
                              $$ = (HEAD_WEB + MENOR + "title" + MAYOR + titulo + MENOR + "/title" + MAYOR + NEXT_LINE); 
                              $$ += MENOR + "body" + MAYOR + NEXT_LINE;
			      $$ += MENOR + "h2" + MAYOR + titulo + MENOR + "/h2" + MAYOR + NEXT_LINE;
                            }

       ;

DESCRIPCION : 'TAG_DESCP' 'TEXT' { $$ = P + $2.replace(/\"/g,"") + END_P + NEXT_LINE; }

            ;

CONTENIDO : 
            VERDADEROFALSO CONTENIDO { $$ = ($1 + $2); }
          | /* empty */ { $$ = ""; }

          ;

VERDADEROFALSO : 'TAG_TRUEFALSE' 'TEXT' RESPUESTAS { $$ = (P + contadorPreguntas + ") " + $2.replace(/\"/g,"") + END_P + NEXT_LINE + $3 + NEXT_LINE); contadorPreguntas++; respuestas.push("truefalse"); }

               ;

RESPUESTAS :  
             'TAG_RIGHT' 'TEXT' RESPUESTAS { $$ = INPUT + contadorPreguntas + "' " + "value='" + TRUE + "'/" + MAYOR + $2.replace(/\"/g,"") + "&lt;br&gt;" + NEXT_LINE + $3; aciertos.push(TRUE);}
           | 'TAG_WRONG' 'TEXT' RESPUESTAS { $$ = INPUT + contadorPreguntas + "' " + "value='" + FALSE + "'/" + MAYOR + $2.replace(/\"/g,"") + "&lt;br&gt;" + NEXT_LINE + $3; }
           | /* empty */ { $$ = ""; }

           ;
	       
%%

var MENOR = "&lt;";
var MAYOR = "&gt;";
var NEXT_LINE = "\n";
var HEAD_FORM = "&lt;! -- Formulario --&gt;" + NEXT_LINE + "&lt;h3&gt;PREGUNTAS&lt;/h3&gt;" + NEXT_LINE;
var P = MENOR + "p" + MAYOR;
var END_P = MENOR + "/p" + MAYOR;
var INPUT = MENOR + "input type='radio' name='respuesta_";
var contadorPreguntas = 1;
var respuestas = [];
var aciertos = [];
var TRUE = "true";
var FALSE = "false";
var END_WEB = "&lt;p&gt;&lt;input type='submit' name='evaluar' value='Evaluar' /&gt;&lt;/p&gt;"
             + NEXT_LINE + "&lt;/form&gt;" + NEXT_LINE + "&lt;/body&gt;" + NEXT_LINE + "&lt;/html&gt;";
var HEAD_WEB = "&lt;html&gt;" + NEXT_LINE + "&lt;head&gt;" + NEXT_LINE;


function generarPHP(descp) {
  
 descp += MENOR + "?php" + NEXT_LINE;
 descp += "  if ((isset($_POST['evaluar'])) && (($_POST['evaluar']) == 'Evaluar')) {" + NEXT_LINE; 
 var i = 1;
 for (i in respuestas) {
  var aux = parseInt(i) + 1;
  if (i == 0) {
    descp += "    if ((!empty($_POST['respuesta_1']))";
  } else {
    descp += " && (!empty($_POST['respuesta_" + aux + "']))";
  }
 }
 descp += ") {" + NEXT_LINE;
 descp += "      echo '&lt;table border=N1N&gt;';".replace(/\N/g,"\"") + NEXT_LINE;
 descp += "      echo '&lt;tr&gt;';" + NEXT_LINE;
 for (i in respuestas) {
  var aux = parseInt(i) + 1;
  descp += "      echo '&lt;td&gt;Pregunta " + aux + "&lt;/td&gt;';" + NEXT_LINE;  
 }
 descp += "      echo '&lt;/tr&gt;';" + NEXT_LINE;
 descp += "      echo '&lt;tr&gt;';" + NEXT_LINE;
 for (i in respuestas) {
  var aux = parseInt(i) + 1;
  descp += "      echo '&lt;td&gt;';" + NEXT_LINE + NEXT_LINE;
  if (respuestas[i] == "truefalse") {     
    descp += "      if ($_POST['respuesta_" + aux +"'] == '" + aciertos[i] + "') {" + NEXT_LINE; 
    descp += "        echo '&lt;div style=Nbackground:#00FF00;N&gt;Bien&lt;/div&gt;';".replace(/\N/g,"\"") + NEXT_LINE;
    descp += "      } else {" + NEXT_LINE;
    descp += "        echo '&lt;div style=Nbackground:#FF0000;N&gt;Mal&lt;/div&gt;';".replace(/\N/g,"\"") + NEXT_LINE;
    descp += "      }" + NEXT_LINE; 
  }
  descp += "      echo '&lt;/td&gt;';" + NEXT_LINE;
 }
 descp += "      echo '&lt;/tr&gt;';" + NEXT_LINE;
 descp += "      echo '&lt;/table&gt;';" + NEXT_LINE;
 descp += "      } else {" + NEXT_LINE;
 descp += "        echo '&lt;p style=Nbackground:#FF0000; display:inline;N&gt;Debe responder a todas las preguntas&lt;/p&gt;';".replace(/\N/g,"\""); + NEXT_LINE;
 descp += "      }" + NEXT_LINE;
 descp += "      unset($_POST['evaluar']);" + NEXT_LINE;
 descp += "    }" + NEXT_LINE;
 descp += "  ?&gt;" + NEXT_LINE;
 return descp; 
 
}