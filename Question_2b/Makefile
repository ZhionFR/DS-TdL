DS_3: DS_3.lex
	lex DS_3.lex
	yacc DS_3.yacc
	cc y.tab.c -lfl liby.a -o DS_3

run: DS_3
	./DS_3 < DS.exemple_quasi.txt

clean:
	rm -f DS_3 lex.yy.c

