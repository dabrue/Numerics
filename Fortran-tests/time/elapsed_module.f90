module timing_module

contains
    
   subroutine elapsed(time1, time2, elapse) 
   ! this routine gives the time that elapsed between times time1 and time2 
   ! as returned by the fourth argument of the DATE_AND_TIME intrinsic
   ! subroutine call. 
   ! time1 and time2 are integer arrays of length 8. 
   ! This subroutine returns elapse, also an integer array of length 8. 
   !
   ! From the documentation of DATE_AND_TIME, the elements of the time arrays
   ! have the following meanings
   !
   ! 1 - year
   ! 2 - month
   ! 3 - day
   ! 4 - time difference in minutes from Greenwich Mean
   ! 5 - hours
   ! 6 - minutes
   ! 7 - seconds
   ! 8 - milliseconds

   implicit none
   integer :: time1(8)
   integer :: time2(8)
   integer :: elapse(8)

   
