DEST	      = 

EXTHDRS	      =

HDRS	      =

LIBRARY	      = libbessel.a

MAKEFILE      = Makefile

OBJS	      = d9b0mp.o \
		d9b1mp.o \
		d9lgmc.o \
		dasyik.o \
		dasyjy.o \
		dbesi.o \
		dbesi0.o \
		dbesi1.o \
		dbesj.o \
		dbesj0.o \
		dbesj1.o \
		dbesk.o \
		dbesk0.o \
		dbesk1.o \
		dbesy.o \
		dbesy0.o \
		dbesy1.o \
		dbsi0e.o \
		dbsi1e.o \
		dbsk0e.o \
		dbsk1e.o \
		dbsknu.o \
		dbsynu.o \
		dcsevl.o \
		dgamlm.o \
		dgamma.o \
		djairy.o \
		dlngam.o \
		dyairy.o \
		initds.o \
		zermsg.o

PRINT	      = pr

SRCS	      = d9b0mp.f \
		d9b1mp.f \
		d9lgmc.f \
		dasyik.f \
		dasyjy.f \
		dbesi.f \
		dbesi0.f \
		dbesi1.f \
		dbesj.f \
		dbesj0.f \
		dbesj1.f \
		dbesk.f \
		dbesk0.f \
		dbesk1.f \
		dbesy.f \
		dbesy0.f \
		dbesy1.f \
		dbsi0e.f \
		dbsi1e.f \
		dbsk0e.f \
		dbsk1e.f \
		dbsknu.f \
		dbsynu.f \
		dcsevl.f \
		dgamlm.f \
		dgamma.f \
		djairy.f \
		dlngam.f \
		dyairy.f \
		initds.f \
		zermsg.f

all:		$(LIBRARY)

$(LIBRARY):	$(OBJS)
		@echo "Loading $(LIBRARY) ... \c"
		@ar cru $(LIBRARY) $(OBJS)
		@ranlib $(LIBRARY)
		@echo "done"

clean:;		@rm -f $(OBJS)

depend:;	@mkmf -f $(MAKEFILE) LIBRARY=$(LIBRARY) DEST=$(DEST)

extract:;	@ar xo $(DEST)/$(LIBRARY)
		@rm -f __.SYMDEF

index:;		@ctags -wx $(HDRS) $(SRCS)

install:	$(LIBRARY)
		@echo Installing $(LIBRARY) in $(DEST)
		@install $(LIBRARY) $(DEST)
		@ranlib $(DEST)/$(LIBRARY)

library:        $(LIBRARY)

print:;		@$(PRINT) $(HDRS) $(SRCS)

tags:           $(HDRS) $(SRCS); @ctags $(HDRS) $(SRCS)

update:         $(DEST)/$(LIBRARY)

$(DEST)/$(LIBRARY): $(SRCS) $(HDRS) $(EXTHDRS)
		@-ar xo $(DEST)/$(LIBRARY)
		@make -f $(MAKEFILE) DEST=$(DEST) install clean
###
