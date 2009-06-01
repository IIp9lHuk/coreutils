DESTDIR =
PREFIX = ${HOME}
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man

CC = tcc
CFLAGS =

PROGS = am \
	echo \
	false \
	rm \
	seq \
	true \
	yes

MANDOCS = am.1 \
	echo.1 \
	seq.1

HTMLDOCS = am.html \
	echo.html \
	seq.html

##############################

all:QV: ${PROGS}

# Programs
am:Q: license.h am.c
	echo ' ' CC ' ' am; ${CC} ${CFLAGS} -o am am.c

echo:Q: license.h echo.c
	echo ' ' CC ' ' echo; ${CC} ${CFLAGS} -o echo echo.c

false:Q: license.h false.c
	echo ' ' CC ' ' false; ${CC} ${CFLAGS} -o false false.c

rm:Q: license.h rm.c
	echo ' ' CC ' ' rm; ${CC} ${CFLAGS} -o rm rm.c

seq:Q: license.h seq.c
	echo ' ' CC ' ' seq; ${CC} ${CFLAGS} -o seq seq.c

true:Q: license.h true.c
	echo ' ' CC ' ' true; ${CC} ${CFLAGS} -o true true.c

yes:Q: license.h yes.c
	echo ' ' CC ' ' yes; ${CC} ${CFLAGS} -o yes yes.c

# Documentation
doc:QV: man html
html:QV: ${HTMLDOCS}
man:QV: ${MANDOCS}
	echo ' ' FIX ' ' man; \
	sed -i -e '10s/ "\[FIXME: source\]" "\[FIXME: manual\]"//' ${MANDOCS}

am.html:Q: am.txt
	echo ' ' HTML ' ' am; asciidoc am.txt

am.xml:Q: am.txt
	echo ' ' XML ' ' am; asciidoc -d manpage -b docbook am.txt

am.1:Q: am.xml
	echo ' ' MAN ' ' am; xmlto -m .manpage-normal.xsl man am.xml

seq.html:Q: seq.txt
	echo ' ' HTML ' ' seq; asciidoc seq.txt

seq.xml:Q: seq.txt
	echo ' ' XML ' ' seq; asciidoc -d manpage -b docbook seq.txt

seq.1:Q: seq.xml
	echo ' ' MAN ' ' seq; xmlto -m .manpage-normal.xsl man seq.xml

echo.html:Q: echo.txt
	echo ' ' HTML ' ' echo; asciidoc echo.txt

echo.xml:Q: echo.txt
	echo ' ' XML ' ' echo; asciidoc -d manpage -b docbook echo.txt

echo.1:Q: echo.xml
	echo ' ' MAN ' ' echo; xmlto -m .manpage-normal.xsl man echo.xml

# Housekeeping
clean:QV:
	for i in ${PROGS}; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.1 *.2 *.3 *.4 *.5 *.6 *.7 *.8; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.html; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.xml; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true

# Installation
install:QV: all
	echo ' ' DIR ' ' ${DESTDIR}/${BINDIR}; mkdir ${DESTDIR}/${BINDIR}/
	for i in ${PROGS}; do \
		echo ' ' INSTALL ' ' $i; cp -f $i ${DESTDIR}/${BINDIR}/$i; \
	done

install-man:QV: man
	echo ' ' DIR ' ' ${DESTDIR}/${MANDIR}/man1; mkdir ${DESTDIR}/${MANDIR}/man1
	for i in ${MAN1DOCS}; do \
		echo ' ' MAN ' ' $i; cp -f $i ${DESTDIR}/${MANDIR}/man1/$i; \
	done

uninstall:QV:
	for i in ${PROGS}; do \
		test -f ${DESTDIR}/${BINDIR}/$i && \
		echo ' ' UNINS ' ' $i && \
		rm -f ${DESTDIR}/${BINDIR}/$i; \
	done || true
	rmdir ${DESTDIR}/${BINDIR}/ || true
	for i in ${MAN1DOCS}; do \
		test -f ${DESTDIR}/${MANDIR}/man1/$i && \
		echo ' ' UNMAN ' ' $i && \
		rm -f ${DESTDIR}/${MANDIR}/man1/$i; \
	done || true
	rmdir ${DESTDIR}/${MANDIR}/man1 || true
