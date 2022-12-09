
CFLAGS=-Wall -Wpossible-overlap -Wimplicit-define -Wcolumn-overflow -Wpossible-truncate -Wunreachable -fdump=ALL -ftraceall

./testing/bin/%: ./testing/src/%.cbl
	echo `date` $< >>build.log
	cobc $(CFLAGS) -t ./testing/lst/$(@F).lst -x -o $@ ./testing/src/$(@F).cbl

./bin/%.so: ./src/%.cbl
	echo `date` $< >>build.log
	cobc $(CFLAGS) -t ./lst/$(*F).lst -o $@ $<

all: ./bin/STACKI.so ./bin/STACKN.so ./bin/STACKP.so ./bin/STACKT.so ./testing/bin/test0001 ./testing/bin/test0002 ./testing/bin/test0003

.PHONY: all test1 test2

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

