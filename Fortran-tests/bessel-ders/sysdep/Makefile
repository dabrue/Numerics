FC            = ifort

FFLAGS        = 

CFLAGS	      =

DEST	      = .

EXTHDRS	      =

HDRS	      =

INSTALL	      = 

LIBRARY	      = lib_sysdep.a

MAKEFILE      = Makefile

OBJS	      = d1mach.o \
		date8.o \
		devcsf.o \
		get_hostnm.o \
		i1mach.o \
		iglobal.o \
		errwrt.o \
		time8.o

PRINT	      = pr


SRCS	      = d1mach.f \
		date8.f \
		devcsf.f90 \
		get_hostnm.f \
		i1mach.f \
		iglobal.f \
		errwrt.f \
		time8.f

SYSHDRS	      =

all:		$(LIBRARY)

$(LIBRARY):	$(OBJS)
		@echo "Loading $(LIBRARY) ..."
		@ar cru $(LIBRARY) $(OBJS)
		@echo "done"

clean:;		@rm -f $(OBJS) core

clobber:;	@rm -f $(OBJS) $(LIBRARY) core tags

depend:;	@mkmf -f $(MAKEFILE) ROOT=$(ROOT)

echo:;		@echo $(HDRS) $(SRCS)

extract:;	@ar x $(DEST)/$(LIBRARY)

index:;		@ctags -wx $(HDRS) $(SRCS)

install:	$(LIBRARY)
		@echo Installing $(LIBRARY) in $(DEST)
		@if [ $(DEST) != . ]; then \
		(rm -f $(DEST)/$(LIBRARY); $(INSTALL) -f $(DEST) $(LIBRARY)); fi

print:;		@$(PRINT) $(HDRS) $(SRCS)

tags:           $(HDRS) $(SRCS); @ctags $(HDRS) $(SRCS)

update:         $(DEST)/$(LIBRARY)

$(DEST)/$(LIBRARY): $(SRCS) $(HDRS) $(EXTHDRS)
		@$(MAKE) -f $(MAKEFILE) ROOT=$(ROOT) DEST=$(DEST) install
