# Contar número de ocorrências de cada multi word expression.
# Este script é muito simples, sempre que acabamos de capturar uma multi word expression
# incrementamos array no indíce igual a essa multi word expression. Isto é facilitado
# pelo facto de que se esse indíce ainda não existir, é automaticamente inicializado a zero.
#
# Depois de terminar, reparei que estávamos a contar algumas expressões idênticas
# como diferentes por causa das maiúsculas. Por essa razão, adicionamos tolower()

BEGIN {
  capture=0;
  justfinished=0;
  mwe="";
}

/<\/mwe>/ {
  capture=0
  justfinished=1
}

capture == 1 {
  mwe = mwe " " tolower($1)
}

justfinished == 1 {
  justfinished=0
  array[mwe]++
  mwe=""
}

/<mwe.*>/ {
  capture=1
}

END {
    for (ind in array) {
      print ind "," array[ind]
    }
}
