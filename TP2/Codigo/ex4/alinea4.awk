# Determinar o dicionário implícito com (lema, pos)
#
# As colunas presentes são: palavra, secção, semestre, lema, pos(part of speech),
# tempoVerbal-modo, num-pessoa, Género, árvore, etc.
#
# É feito cuidado especial para que combinações de palavra + lema + pos não se repitam.
# Cada linha de output deste programa é imprimida no formato palavra:(lema,pos),(lema,pos),(lema,pos),[...]

BEGIN {}

# pos is $5
NF >= 5 {

  palavra = tolower($1)
  lema = tolower($4)
  pos = $5

  # Evitar entradas repetidas
  if (!((palavra lema pos) in arrayAux)) {

    # Marcar esta combinacao para evitar repetidos
    arrayAux[palavra lema pos] = 1

    # Inciar a entrada no dicionario
    if (!(palavra in array)) {
      array[palavra] = ""
    } else {
      # Adicionar virgula
      array[palavra] = array[palavra] ","
    }

    # Esta lista de parts of speech por extenso não é exaustiva
    if (pos == "V") {
      pos = "Verbo"
    } else if (pos == "N") {
      pos = "Nome"
    } else if (pos == "ADJ") {
      pos = "Adjetivo"
    } else if (pos == "ADV") {
      pos = "Advérbio"
    } else if (pos == "DET_artd") {
      pos = "Determinante artigo definido"
    } else if (pos == "DET_arti") {
      pos = "Determinante artigo indefinido"
    } else if (pos == "NUM_year_date_card") {
      pos = "Número cardinal ano/data"
    } else if (pos == "NUM_card") {
      pos = "Número cardinal"
    }

    array[palavra] = array[palavra] "(" lema "," pos ")"
  }
}

END {
    for (ind in array) {
      print ind "  :  " array[ind]
    }
}
