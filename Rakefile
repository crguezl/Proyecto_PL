# Rakefile correspondiente al proyecto Generador de Exámenes
#
# Para ver las distintas fases de la ejecución, usar task desarrollo

desc "Task por defecto"
task :default do
  sh "jison javascript/generador_examen.jison -o javascript/generador_examen.js"
  sh "mv javascript/generador_examen.js javascript/generador_examen_temp.js"
  sh "js-beautify javascript/generador_examen_temp.js > javascript/generador_examen.js"
  sh "rm -f javascript/generador_examen_temp.js"
end

desc "Task indicativo de las distintas acciones"
task :detallado do
  puts " "
  puts "*---------------------*"
  puts " GENERADOR DE EXÁMENES"
  puts "*---------------------*"
  puts " "
  puts " "
  puts "1) Compilación de la gramática jison"
  puts "------------------------------------"
  puts " "
  sh "jison javascript/generador_examen.jison -o javascript/generador_examen.js"
  puts " "
  puts "2) Indentación adecuada al código generado por jison"
  puts "----------------------------------------------------"
  puts " "
  sh "mv javascript/generador_examen.js javascript/generador_examen_temp.js"
  sh "js-beautify javascript/generador_examen_temp.js > javascript/generador_examen.js"
  puts " "
  puts "3) Limpieza de ficheros temporales"
  puts "----------------------------------"
  puts " "
  sh "rm -f javascript/generador_examen_temp.js"
  puts " "
  puts "*----------------------------*"
  puts " Rake terminado sin problemas"
  puts "*----------------------------*"
end
