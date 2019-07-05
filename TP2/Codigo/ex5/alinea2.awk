#!/usr/bin/gawk -f

BEGIN{}

/noun.*proper/{
	nomes[$3]++;
}

END{	
	for(ind in nomes){
		print nomes[ind] "," ind
	}
}
