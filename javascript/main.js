$(document).ready(function(){
  $("#B_GENERAR").click(function(){    
     try {
       var result = generador_examen.parse($("#TA_INPUT").val());
       $("#OUTPUT").html(result);
     } catch (e) {
       $("#OUTPUT").html(String(e));
     }	  
  });
});
