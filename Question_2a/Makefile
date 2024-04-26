DS_2: DS_2.lex
	lex DS_2.lex
	yacc DS_2.yacc
	cc y.tab.c -lfl liby.a -o DS_2

run: DS_2
	./DS_2 < DS.exemple_quasi.txt

clean:
	rm -f DS_2 lex.yy.c

