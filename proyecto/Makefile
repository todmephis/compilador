PROJ = compilador
PREFIX = httpdConfig
SRC = src
OUT = out
LEX_SOURCE = ${PREFIX}.l
BISON_SOURCE = ${PREFIX}.y
SOURCES = ${OUT}/${PREFIX}.yy.c ${OUT}/${PREFIX}.tab.c

all:${SOURCES}
	gcc -o ${OUT}/${PROJ} ${SOURCES} -lfl

${OUT}/${PREFIX}.yy.c:${SRC}/${LEX_SOURCE}
	flex -l -o ${OUT}/${PREFIX}.yy.c ${SRC}/${PREFIX}.l  

${OUT}/${PREFIX}.tab.c:${SRC}/${BISON_SOURCE}
	bison -dv -o ${OUT}/${PREFIX}.tab.c ${SRC}/${PREFIX}.y 

clean:
	rm ${OUT}/*