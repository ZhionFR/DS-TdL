DS_4: DS_4.lex
	lex DS_4.lex
	yacc DS_4.yacc
	cc y.tab.c -lfl liby.a -o DS_4

run: DS_4
	./DS_4 < DS.exemple_quasi.txt

clean:
	rm -f DS_4 lex.yy.c

