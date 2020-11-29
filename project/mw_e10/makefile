SDK_TOP = ../..
INCDIR = $(SDK_TOP)/include
LIBDIR = $(SDK_TOP)/lib

DBGFLAG = -DDEBUG
CC = wla-65816
CFLAGS = -I$(INCDIR)
LD = wlalink
LDFLAGS = -v -S -L$(LIBDIR)

SFILES = main.S
IFILES = 
OFILES = main.o

.PHONY: all clean debug sound

all: sound $(OFILES) makefile
	$(LD) $(LDFLAGS) linkfile mw_e10.sfc

debug: sound
	$(CC) $(CFLAGS) $(DBGFLAG) -o main.o main.S
	$(LD) $(LDFLAGS) linkfile mw_e10.sfc

sound:
	@$(MAKE) -C sound --no-print-directory

main.o: main.S
	$(CC) $(CFLAGS) -o main.o main.S


$(OFILES): $(HFILES)


clean:
	@$(MAKE) -C sound --no-print-directory $@
	rm -f $(OFILES) core *~ mw_e10.sfc mw_e10.sym
