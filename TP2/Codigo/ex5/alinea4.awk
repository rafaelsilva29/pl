#!/usr/bin/gawk -f

BEGIN{}

NF>0{
    word = tolower($2)
    lema = tolower($3)
    pos = $5

    # Evitar entradas repetida
    if(!((word lema pos) in arrayAux)){

        # Marcar esta combinação encontrada para evitar repetições
        arrayAux[word lema pos] = 1

        # Iniciar entrada no dicionario
        if(!word in array){
            array[word] = ""
        } else {
            # Adiciona virgula
            array[word] = array[word] ","
        }

        array[word] = array[word] "(" lema "," pos ")"
    }
}

END{
    for(ind in array){
        print ind, "::", array[ind]
    }
}