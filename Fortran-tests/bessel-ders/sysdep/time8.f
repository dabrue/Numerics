*deck Time8
      subroutine Time8 ( HTime )
c
c------------------------------------------------------------------------------
c
c >>> Time8 -- returns current time in 8 character string
c
c------------------------------------------------------------------------------
c
      implicit none
c
      character*(*) HTime
      character*24   Now,ctime
      integer inow,time
c      external time
c
c---------------------------- execution begins here ---------------------------
c
c	... this version for the HP ...
c
c   $NOSTANDARD SYSTEM ON
      inow = time()
      Now =  ctime(inow)

c   $NOSTANDARD SYSTEM OFF
c
c      write(*,*) inow
c      write(*,*) Now
      HTime    = Now(12:19)
c      write(*,*) HTime
      return
      end
