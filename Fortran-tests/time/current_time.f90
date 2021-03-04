subroutine current_time(now)
! Return a character string containing the current date and time, local
implicit none

character(len=25) :: now
character(len=4) :: year
character(len=2) :: month
character(len=2) :: day
character(len=3) :: zone
character(len=2) :: hour
character(len=2) :: minute
character(len=2) :: second
character(len=1) :: tmp

character(len=10) :: date, time, tzone

integer :: values(8)

call date_and_time(date, time, tzone, values)

write(year, '(I4)') values(1)
if (values(2) < 10) then
    write(tmp,'(I1)') values(2)
    month='0'//tmp
else
    write(month,'(I2)') values(2)
endif

if (values(3) < 10) then
    write(tmp,'(I1)') values(3)
    day='0'//tmp
else
    write(day,'(I2)') values(3)
endif

write(zone,'(I3)') values(4)/60   ! Time zone returned in minutes off of GMT

if (values(5) < 10) then
    write(tmp,'(I1)') values(5)
    hour='0'//tmp
else
    write(hour,'(I2)') values(5)
endif

if (values(6) < 10) then
    write(tmp,'(I1)') values(6)
    minute='0'//tmp
else
    write(minute,'(I2)') values(6)
endif

if (values(7) < 10) then
    write(tmp,'(I1)') values(7)
    second='0'//tmp
else
    write(second,'(I2)') values(7)
endif

now=year//'-'//month//'-'//day//' '//hour//':'//minute//':'//second//' '//zone

end subroutine current_time
