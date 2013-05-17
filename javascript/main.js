var result = "";

$(document).ready(function(){
  $("#B_GENERAR").click(function(){   
    document.getElementById('OUTPUT').className = 'unhidden'; 
    document.getElementById('B_DESCARGAR').className = 'unhidden';
     try {
       result = generador_examen.parse($("#TA_INPUT").val());
       $("#OUTPUT").html(result);
     } catch (e) {
       $("#OUTPUT").html(String(e));
     }	  
  });
  $("#B_DESCARGAR").click(function(){
    download();
  });
});

function download() {
 
  var result_replaced = clean();
  location.href='data:application/download,' + encodeURIComponent(result_replaced);
  
}

function clean() {
  
  /* Etiquetas */
  var aux = result;
  aux = (aux.replace(/&lt;/g,"<")).replace(/\&gt;/g,">");
  /* Valores especiales */  
  aux = "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />" + aux;
  
  return aux;
  
}
