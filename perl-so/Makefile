CFLAGS=-fPIC

.PHONY: all clean

all: callee.so

callee.so: callee.o
	$(CC) -shared -fPIC -o $@ $^

callee.o: callee.c

clean:
	$(RM) -f *.o callee.so *~
