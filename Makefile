all: rahhid

HIDAPI_LIB_NAME ?= hidapi

CFLAGS += -Wall -Werror -Wextra -Wdate-time
CFLAGS += -Wformat -Wformat-security -D_FORTIFY_SOURCE=2
CFLAGS += -Wcast-align -Wcast-qual -Wchar-subscripts
CFLAGS += -Wformat-nonliteral -Wpointer-arith -Wredundant-decls
CFLAGS += -Wreturn-type -Wshadow -Wswitch -Wunused-parameter -Wwrite-strings
CFLAGS += -fstack-protector-strong -fPIC -fPIE

LDFLAGS ?=

DESTDIR ?=
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

ifeq ($(shell uname -s), Linux)
	HIDAPI_LIB_NAME = hidapi-libusb
	LDFLAGS += -pie -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -Wl,--as-needed -Wl,-Bsymbolic-functions -Wl,--fatal-warnings
endif

rahhid: rahhid.o
	$(CC) $(CFLAGS) $(LDFLAGS) -Os -o rahhid rahhid.o -lm $(shell pkg-config --libs $(HIDAPI_LIB_NAME))

rahhid.o: rahhid.c
	$(CC) $(CFLAGS) $(shell pkg-config --cflags $(HIDAPI_LIB_NAME)) -Os -o rahhid.o -c rahhid.c

clean:
	$(RM) -f rahhid rahhid.o

distclean: clean

install: rahhid
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 rahhid $(DESTDIR)$(BINDIR)