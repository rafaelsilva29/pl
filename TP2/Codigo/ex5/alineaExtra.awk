
BEGIN {

  exists=0
  word
  saveProx=0
  saved=0
  numSugestion=0
  sugestedWord
  putComma=0

  pritn "<!DOCTYPE html>"
  print "<html lang='pt-PT'>"
	print "<body>"

	print "<h1>" word "</h1>"

	print "<div id='piechart'></div>"

	print "<script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>"

	print "<script type='text/javascript'>"
	print "// Load google charts"
	print "google.charts.load('current', {'packages':['corechart']});"
	print "google.charts.setOnLoadCallback(drawChart);"

	print "// Draw the chart and set the chart values"
	print "function drawChart() {"
	print "var data = google.visualization.arrayToDataTable(["
}

$2~/^[a-zA-Z]+[^']?[a-zA-Z]*$/ {

	# word after the one which we are looking for
	if(saveProx==1) {
		previsao[$2]++;
		saveProx=0;
		saved++;
	}

	# check if its the word we are looking for
	if(word==$2) {
		exists++;
		saveProx=1;
	}

}

END {
	for (i in previsao) {

    	if (previsao[i] > numSugestion) {
    		numSugestion=previsao[i];
    		sugestedWord=i;
    	}

    	# Print , after the first argument
    	if (putComma) print ",\n"
        else print "['Prevision', 'Word possibilities'],"

    	# Print the arguments for html graph
    	print "['" i "', " previsao[i] "]"

    	putComma=1
    }

  print "]);"

  print "// Optional; add a title and set the width and height of the chart"
  print "var options = {'title':'Palavra seguinte: " sugestedWord "', 'width':880, 'height':640};"

  print "// Display the chart inside the <div> element with id='piechart'"
  print "var chart = new google.visualization.PieChart(document.getElementById('piechart'));"
  print "chart.draw(data, options);"
  print "}"
  print "</script>"

  print "</body>"
  print "</html>"
}