SDK_TOP = ../..
INCDIR = $(SDK_TOP)/include
LIBDIR = $(SDK_TOP)/lib

DBGFLAG = -DDEBUG
CC = wla-65816
CFLAGS = -I$(INCDIR)

SFILES = main.S
IFILES = 
OFILES = dbbrk.lib

.PHONY: all clean install

all: $(OFILES) makefile

dbbrk.lib: main.S
	$(CC) $(CFLAGS) -l dbbrk.lib main.S


$(OFILES): $(HFILES)

install:
	move /Y dbbrk.lib $(LIBDIR)

clean:
	rm -f $(OFILES) core *~
