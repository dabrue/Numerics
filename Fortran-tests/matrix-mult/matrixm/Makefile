SHELL   = /bin/sh

#PROGNAME is the name of the executable, ie. xeq_progname-0_$(FC)
PROGNAME = progname-0

# List of Potentials for latter use.
POTS = lifhb hpos lsth tmud2 dmbe pkh3 h2oex h2ogr h2odp fh2t5 heh2 lifh

# list here all necessary namelist files and their location. This is for backups
NAMELISTS = 

# DIRECTORY FOR DOCUMENTATION
DOCDIR= docs


# Determine Operating system.
SYSTEM = $(shell uname)

include Makefile.opt

# Program specific information for source directories and source files.
PROGRAM = bin/xeq_$(PROGNAME)_$(FC)_$(ARCH)

TIME = $(shell date '+%F')

SMAIN  = $(shell ls src/*.main)

SLOC = $(shell ls src/*)

MODLOC = $(shell ls modules/*)

SRCS  = $(SLOC:src/%=%)

MODSRCS = $(MODLOC:modules/%=%)

BASES = $(basename $(SRCS))

MODBASES = $(basename $(MODSRCS))

# 32 BIT MKL LIBS
# EXLIBS contains external libraries that are not remade 
EXLIBS  = -L/opt/intel_mkl/lib/em64t -lmkl_lapack -lmkl_em64t -lguide -lpthread #-L/opt/intel_fce/lib/ -limf -lpthread

# LIBS contains libraries that are remade and need recompiled if updated
LIBS = 

BFILES  = $(SRCS:%=$(BACKUP)/%)

OBJS  = $(addsuffix .o, $(BASES))

MODS = $(addsuffix .mod, $(MODBASES))

MODOBJS = $(addsuffix .o, $(MODBASES))

OLOC  = $(OBJS:%=$(OBJDIR)/%) $(MODOBJS:%=$(OBJDIR)/%)

# ADD TO VPATH ALL DIRECTORIES CONTAINING SOURCE CODE FOR THIS PROGRAM
VPATH   = .:src:modules:$(OBJDIR):backup

# Locations of temporary bin (DEST), install, backup, objdir and include directories.

SRCDIR  = src

#MODULES should be placed in the modules/ directory
MODDIR = modules

# THE EXECUTABLE WILL BE PLACED IN THE bin/ DIRECTORY
DEST    = bin

INSTDIR = $(HOME)/bin

BACKUP	= backup

# OBJDIR contains all of the object files. The objs/$(FC) dirctory may need created before compiling
OBJDIR	= objs/$(FC)_$(ARCH)

MODFILEDIR = modfiles

INCDIR  = include

PRINT   = lpr

# Rules for making object files from FORTRAN source
%.o : %.main
	$(FC) $(FFLAGS) -module $(MODFILEDIR) -I$(INCDIR) $(DEBUGSTAT) -c $< -o $(OBJDIR)/$*.o
%.o : %.f90
	$(FC) $(FFLAGS) -module $(MODFILEDIR) -I$(INCDIR) $(DEBUGSTAT) -c $< -o $(OBJDIR)/$*.o
%.o : %.f
	$(FC) $(FFLAGS) -module $(MODFILEDIR) -I$(INCDIR) $(DEBUGSTAT) -c $< -o $(OBJDIR)/$*.o
%.o : %.for
	$(FC) $(FFLAGS) -module $(MODFILEDIR) -I$(INCDIR) $(DEBUGSTAT) -c $< -o $(OBJDIR)/$*.o
%.o : %.F
	$(FC) $(FFLAGS) -module $(MODFILEDIR) -I$(INCDIR) $(DEBUGSTAT) -c $< -o $(OBJDIR)/$*.o

all:		$(PROGRAM)

# Link objects to produce executables.
$(PROGRAM):     $(MODOBJS) $(OBJS) $(LIBS)
		@echo Linking to produce executable $(PROGRAM)
		@echo $(LD) $(LDFLAGS) $(OLOC) $(LIBS) $(EXLIBS)
		@$(LD) $(LDFLAGS) $(OLOC) $(LIBS) $(EXLIBS) -o $(PROGRAM)

		
# Delete object and core files.
clean:;
		@echo Removing $(OLOC) core
		@rm -f $(OLOC) core
		@rm -f $(DEST)/* core

# Delete object, executable, core and tag files.
realclean:;
		@echo Removing ALL Objects, Programs and core files.
		@rm -f $(OBJDIR)/*/*.o  $(DEST)/xeq_* core
		@touch $(SRCDIR)/*

# List source files.
echo:;
		@echo $(SRCS)

# Install executable in users bin directory.
install:	$(PROGRAM)
		@echo Installing $(PROGRAM) in $(INSTDIR)
		@-strip $(PROGRAM)
		@if [ $(INSTDIR) != . ]; then \
		(rm -f $(INSTDIR)/$(PROGRAM); $(INSTALL) $(PROGRAM) $(INSTDIR)); fi

# Print all source files.
print:
		@$(PRINT) $(HDRS) $(SRCS)

# Backup source files before making complicated changes.
backup: FORCE
		@echo Making Backup:
		@mkdir $(PROGNAME)_$(TIME)
		@echo "    * Backing up src"
		@cp -r src $(PROGNAME)_$(TIME)
		@echo "    * Backing up modules"
		@cp -r modules $(PROGNAME)_$(TIME)
		@echo "    * Backing up lib"
		@cp -r lib $(PROGNAME)_$(TIME)
		@echo "    * Backing up namelists"
		@mkdir $(PROGNAME)_$(TIME)/namelists
		@for i in ${NAMELISTS}; \
			do \
				(cp -u $$i $(PROGNAME)_$(TIME)/namelists/$$i) \
			done
		@echo "    * Backing up docs"
		@cp -r $(DOCDIR) $(PROGNAME)_$(TIME)
		@echo "    * Backing up Makefiles"
		@cp Makefile* $(PROGNAME)_$(TIME)
		@echo making tarfile $(BACKUP)/$(PROGNAME)_$(TIME).tar.bz
		@tar cjf $(BACKUP)/$(PROGNAME)_$(TIME).tar.bz $(PROGNAME)_$(TIME)
		@rm -rf $(PROGNAME)_$(TIME)
FORCE:

# Make Variables.
prvar:
		@echo Variables used in this Makefile
		@echo FC=$(FC)
		@echo SHELL=$(SHELL)
		@echo PROGNAME=$(PROGNAME)
		@echo POTS=$(POTS)
		@echo FFLAGS=$(FFLAGS)
		@echo INCDIR=$(INCDIR)
		@echo LD=$(LD)
		@echo LDFLAGS=$(LDFLAGS)
		@echo DEBUGSTAT=$(DEBUGSTAT)
		@echo SRCS=$(SRCS)
		@echo SLOC=$(SLOC)
		@echo OLOC=$(OLOC)
		@echo BASES=$(BASES)
		@echo MODBASES=$(MODBASES)
		@echo BFILES=$(BFILES)
		@echo VPATH=$(VPATH)
		@echo DEST=$(DEST)
		@echo OBJS=$(OBJS)
		@echo MODOBJS=$(MODOBJS)
		@echo MODS=$(MODS)
