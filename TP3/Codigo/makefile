virtual: lex.yy.o y.tab.o
	gcc -o ngen y.tab.o lex.yy.o -ll
	./ngen < config.in
	rm *.o *.c *.h
	
y.tab.o: y.tab.c
	gcc -c y.tab.c

y.tab.c y.tab.h: ngen.y
	yacc -d ngen.y

lex.yy.c: ngen.l y.tab.h
	flex ngen.l
