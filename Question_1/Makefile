DS_1: DS_1.lex
	lex DS_1.lex
	gcc -lfl lex.yy.c -o DS_1

run: DS_1
	./DS_1 < DS_exemple.txt > DS_Output.txt

clean:
	rm -f DS_1 lex.yy.c

