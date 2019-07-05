PL - 18/19 - TP2

Exercicio:
	2.5) Processador de textos preanotados com Freeling

		a) contar o número de Extratos.
			
			Compilar:
				> gawk -f alinea1.awk Files/fileName_Input > Alinea1/fileName_Output.txt

	    b) calcular a lista dos personagens do Harry Potter (nomes próprios) e respectivo numéro de ocorrências.

	    	Compilar: 
	    		> gawk -f alinea2.awk Files/harrypotterX | sort -r -n | column -t -s "," > Alinea2/personagensX.txt
		
		c) calcular a lista dos verbos, substantivos, adjectivos e advérbios PT e criar um ficheiro HTML com cada uma destas listas.

			Compilar:
				> gawk -f alinea3.awk Files/harrypotterX

		d) determinar o dicionário implícito no córpora – lista contendo os lema, pos e palavras dele derivadas.

			Compilar: 
				> gawk -f alinea4.awk Files/fileName_Input | sort > Alinea4/fileName_Output.txt

	-> Extra: 
			- Sugerir próxima palavra com base numa palavra introduzida.

		Compilar:
			> gawk -f alineaExtra.awk -v word='someWord' Files/fileName_Input > Extra/fileName_Output.html

				