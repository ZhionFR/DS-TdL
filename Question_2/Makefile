DS_2: DS_2.lex
	lex DS_2.lex
	yacc DS_2.y
	cc y.tab.c -lfl liby.a -o DS_2

run: DS_2
	./DS_2 < DS_exemple.txt > DS_Output.txt

clean:
	rm -f DS_2 lex.yy.c

