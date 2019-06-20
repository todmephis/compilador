#!/bin/bash
flex ./c.l
gcc ./lex.yy.c -ll
./a.out < ./clase1.c  > ./salida.html
#open ./salida.html
