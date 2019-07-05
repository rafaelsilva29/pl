# Contar número de extratos, parágrafos, e frases.

BEGIN {
  ext=0;
  p=0;
  s=0;
}

/<\/ext>/ {
  ext++;
}

/<\/p>/ {
  p++;
}

/<\/s>/ {
  s++;
}

END {
    print "FileName: " FILENAME
    print "Extratos (<ext>): " ext
    print "Paragrafos (<p>): " p
    print "Frases (<s>): " s
}
