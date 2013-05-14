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
 
  location.href='data:application/download,' + encodeURIComponent(result);
  
}
