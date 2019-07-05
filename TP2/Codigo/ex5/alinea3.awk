#!/usr/bin/gawk -f

BEGIN {
	countVerbos=0; countSubs=0; countAdj=0; countAdv=0;
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h2>Index Alinea 3 - %s</h2>\n\t<table border='1'>\n\t\n", ARGV[1] > "indexAlinea3.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h3>Lista de Verbos</h3>\n\t<table border='1'>\n\t<tr><th>Verbo</th></tr>\n" > "Alinea3/verbos.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h3>Lista de Substantivos</h3>\n\t<table border='1'>\n\t<tr><th>Substantivo</th></tr>\n" > "Alinea3/substantivos.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h3>Lista de Adjetivos</h3>\n\t<table border='1'>\n\t<tr><th>Adjetivo</th></tr>\n" > "Alinea3/adjetivos.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h3>Lista de Adverbios</h3>\n\t<table border='1'>\n\t<tr><th>Adverbio</th></tr>\n" > "Alinea3/adverbios.html";
}

/\=verb/{
         verbos[$3]++;
}

/\=noun/{
        nomes[$3]++;
}

/\=adjective/{
        adjectivos[$3]++;
}

/\=adverb/{
        adverbios[$3]++;
}

END {   
        for(ind in verbos){
                printf "\t\t<tr><td>%s</td></tr>\n", ind > "Alinea3/verbos.html";     
                countVerbos++;     
        }
        for(ind in nomes){
                printf "\t\t<tr><td>%s</td></tr>\n", ind > "Alinea3/substantivos.html";
                countSubs++;
        }
        for(ind in adjectivos){
                printf "\t\t<tr><td>%s</td></tr>\n", ind > "Alinea3/adjetivos.html";
                countAdj++;
        }
        for(ind in adverbios){ 
                printf "\t\t<tr><td>%s</td></tr>\n", ind > "Alinea3/adverbios.html";
                countAdv++;
        }
	printf "\t\t<tr><th><a href=\"Alinea3/verbos.html\">Verbos</a></th><th>%s</th></tr>\n", countVerbos > "indexAlinea3.html";
	printf "\t\t<tr><th><a href=\"Alinea3/substantivos.html\">Substantivos</a></th><th>%s</th></tr>\n",countSubs > "indexAlinea3.html";
	printf "\t\t<tr><th><a href=\"Alinea3/adjetivos.html\">Adjetivos</a></th><th>%s</th></tr>\n", countAdj > "indexAlinea3.html";
	printf "\t\t<tr><th><a href=\"Alinea3/adverbios.html\">Adverbios</a></th><th>%s</th></tr>\n", countAdv > "indexAlinea3.html";
	printf "\t</table>\n\t</body>\n</html>" > "Alinea3/verbos.html";
	printf "\t</table>\n\t</body>\n</html>" > "Alinea3/substantivos.html";
	printf "\t</table>\n\t</body>\n</html>" > "Alinea3/adjetivos.html";
	printf "\t</table>\n\t</body>\n</html>" > "Alinea3/adverbios.html";
	printf "\t</table>\n\t</body>\n</html>" > "indexAlinea3.html";
}