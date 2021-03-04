*deck Date8
      subroutine Date8 ( HDate )
c
c >>> Date8 -- makes the current date in an 8-character string
c		This version for the HP (compile/load with +U77)
c
      implicit none
c
      character*(*) HDate
c
      character*8   Today
      character*10   now
c
      call date_and_time(today,now)
      HDate = Today
c
      return
      end
