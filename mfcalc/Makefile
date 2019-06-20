all:
	clear
	bison *.y -d
	flex *.l
	gcc *.c -lm -o calc
clear:
	rm calc mfcalc.t* lex* -f
