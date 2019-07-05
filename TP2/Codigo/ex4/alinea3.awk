# Calcule a lista dos verbos PT: (Lema, para palavras com pos=V) e respetivo número de ocorrências.
#
# As colunas presentes são: palavra, secção, semestre, lema, pos(part of speech),
# tempoVerbal-modo, num-pessoa, Género, árvore, etc.

BEGIN {}

$5 == "V" {
  lema = tolower($4) 
  array[lema]++  
}

END {
    for (i in array) {
      print i "," array[i]
    }
}
