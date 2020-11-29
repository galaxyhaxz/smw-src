SDK_TOP = ../../..
INCDIR = $(SDK_TOP)/include
LIBDIR = $(SDK_TOP)/lib

CC = wla-spc700
CFLAGS = -I$(INCDIR)
LD = wlalink
LDFLAGS = -v -S -L$(LIBDIR)

SFILES = engine.S music0.S music1.S music2.S samples.S
IFILES = 
OFILES = engine.o music0.o music1.o music2.o samples.o

all: $(OFILES) makefile
	$(LD) $(LDFLAGS) linkfile_e engine.bin
	$(LD) $(LDFLAGS) linkfile_0 music0.bin
	$(LD) $(LDFLAGS) linkfile_1 music1.bin
	$(LD) $(LDFLAGS) linkfile_2 music2.bin
	$(LD) $(LDFLAGS) linkfile_3 samples.bin

engine.o: engine.S
	$(CC) $(CFLAGS) -o engine.o engine.S

music0.o: music0.S
	$(CC) $(CFLAGS) -o music0.o music0.S

music1.o: music1.S
	$(CC) $(CFLAGS) -o music1.o music1.S

music2.o: music2.S
	$(CC) $(CFLAGS) -o music2.o music2.S

samples.o: samples.S
	$(CC) $(CFLAGS) -o samples.o samples.S


$(OFILES): $(HFILES)


clean:
	rm -f $(OFILES) core *~ engine.bin music*.bin samples.bin *.sym
