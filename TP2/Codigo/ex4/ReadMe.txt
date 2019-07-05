PL - 18/19 - TP2

Exercicio:
	2.4) Processador de CETEMPúblico

		a) contar o número de Extratos, Paráfrafos e Frases.

			Compilar:
				> gawk -f alinea1.awk Files/file_Input.txt > Alinea1/file_Output.txt

		b) extrair a lista das multi-word-expressions e respectivo número de ocorrências.

			Compilar:
				> gawk -f alinea2.awk Files/file_Input.txt | sort -k 2 -t "," -g | column -t -s "," > Alinea2/file_Output.txt

		c) calcular a lista dos verbos PT: (Lema, para palavras com pos=V) e respectivo número de ocorrências.

			Compilar:
				> gawk -f alinea3.awk Files/file_Input.txt | sort -k 2 -t "," -g | column -t -s "," > Alinea3/file_Output.txt

		d) determinar o dicionário implícito no córpora – calcule a lista das palavras associando-lhes os possíveis (lema, pos)

			Compilar:
				> gawk -f alinea4.awk Files/file_Input.txt | sort > Alinea4/file_Output.txt
				