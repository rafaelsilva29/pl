#!/usr/bin/gawk -f

BEGIN { 
    count=0;
}

$0~/^$/{ 
    count++ 
}

END {  
    print "Numero de extratos: " count 
    print "Nome do ficheiro: " FILENAME
}
