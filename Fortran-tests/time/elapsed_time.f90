subroutine elapsed_time(ti, tf, td)
! this subroutine returns the difference in time between 
! times ti ( time initial) and tf (time final)
! 
! as arguments, it takes ti, an integer array of 8 elements
! as returned by the "values" argument of intrinsic function
! date_and_time. date_and_time requires four arguments:
! date_and_time(date,time,zone,values), where date, time and zone are
! characters of len 10 or more, and values is the integer array. 
! 
! the integer array contains the following
! value(1) = year
! value(2) = month
! value(3) = day of month
! value(4) = Time difference from UTC in minutes
! value(5) = hour of the day
! value(6) = minute of the hour
! value(7) = seconds of the minute
! value(8) = milliseconds of the second
! 
! this routine takes the difference in time from the times given in 
! tf and ti and returns the elapsed time in the character variable 
! td, which contains the number of hours elapsed in the form
! hh:mm:ss.mss 
! td should be a character of length 13 or more. 
!
! Note that this routine does not take into account daylight savings, 
! leap year, or leap anything for that matter. 
implicit none

character*(*) :: td
character(len=2) :: ss, mm
character(len=3) :: hh, mss
integer :: ti(8), tf(8)
integer :: years, days, mins, hours, sec, msec, mon
integer :: ydayf, ydayi, dayofyear


years=tf(1)-ti(1)  ! difference between years
hours=tf(5)-ti(5)
mins=tf(6)-ti(6)
sec=tf(7)-ti(7)
msec=tf(8)-ti(8)

! convert months and days to the day of the year instead of day of the month. 
ydayi=dayofyear(ti(2), ti(3))
ydayf=dayofyear(tf(2), tf(3))

days=ydayf-ydayi

! convert days to hours
hours=hours+days*24

! we now have difference in hours, minutes, seconds, milliseconds
! now make sure none of the differences are negative (or out of range!)

! check milliseconds
if (msec < -999 .or. msec > 999) then
   stop "Elapsed Time Error: msec out of range"
else if (msec < 0) then
   msec=msec+1000
   sec=sec-1
end if

! check seconds
if (sec < -60 .or. sec > 60) then
   stop "Elapsed Time Error: seconds out of range"
else if (sec < 0 ) then
   sec=sec+60
   mins=mins-1
endif

! check minutes
if (mins < -59 .or. mins > 59 ) then
   stop "Elapsed Time Error: minutes out of range"
else if (mins < 0) then
   mins=mins+60
   hours=hours-1
end if

! now have time in hours, minutes, seconds, milliseconds. 
! construct character string
if (hours<10) then
   write(hh,'("00",I1)') hours
else if (hours >= 10 .and. hours <= 99) then
   write(hh,'("0",I2)') hours
else if (hours > 999) then
   write (hh,"(A3)") "---"
else
   write(hh,'(I3)') hours
endif

   
if (mins<10) then
   write(mm,'("0",I1)') mins
else 
   write(mm,"(I2)") mins
endif

write(ss,"(I2)") sec
write(mss,"(I3)") msec

!if (mins < 10) mm="0"//trim(mm)
if (hours < 10) hh="00"//trim(hh)
if (hours >= 10 .and. hours <100) hh="0"//trim(hh)

td=hh//":"//trim(mm)//":"//ss//"."//mss


end subroutine elapsed_time

integer function dayofyear(mon,mday)
!this function takes the month and the day
! and returns the day of the year integer
integer :: mon, mday, yday

select case (mon)
! depending on what month mon is, a certain
! number of days have already passed. 
       case(2)
          ! it is Feb. Include the days from Jan. 
          yday=31
       case(3)
          ! is is March, include days from Feb. and Jan.
          yday=59
       case(4)
          ! and so on...
          yday=90
       case(5)
          yday=120
       case(6)
          yday=151
       case(7)
          yday=181
       case(8)
          yday=212
       case(9)
          yday=243
       case(10)
          yday=273
       case(11)
          yday=304
       case(12)
          ! it is December, include days from prev. 11 months. 
          yday=334
end select

! now add on whatever the day of the month is. 
yday=yday+mday
dayofyear=yday

return 
end function dayofyear
