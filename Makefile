
CFLAGS=-Wall -Wpossible-overlap -Wimplicit-define -Wcolumn-overflow -Wpossible-truncate -Wunreachable -fdump=ALL -ftraceall

./testing/bin/%: ./testing/src/%.cbl
	echo `date` $< >>build.log
	cobc $(CFLAGS) -t ./testing/lst/$(@F).lst -x -o $@ ./testing/src/$(@F).cbl

./bin/%.so: ./src/%.cbl ./src/STACKAB.cpy
	echo `date` $< >>build.log
	cobc $(CFLAGS) -t ./lst/$(*F).lst -I ./src -o $@ $<

all: ./bin/STACKI.so ./bin/STACKN.so ./bin/STACKP.so ./bin/STACKT.so ./testing/bin/test0001 ./testing/bin/test0002 ./testing/bin/test0003

.PHONY: all test1 test2

init:
	if [ ! -d lst ]; then \
		mkdir lst; \
	fi
	if [ ! -d bin ]; then \
		mkdir bin; \
	fi
	if [ ! -d testing/lst ]; then \
		mkdir testing/lst; \
	fi
	if [ ! -d testing/bin ]; then \
		mkdir testing/bin; \
	fi

test1:
	echo `date` $@ >>build.log
	cd bin; \
	../testing/bin/test0001;

test2:
	echo `date` $@ >>build.log
	cd bin; \
	../testing/bin/test0002;

test3:
	echo `date` $@ >>build.log
	cd bin; \
	../testing/bin/test0003;

