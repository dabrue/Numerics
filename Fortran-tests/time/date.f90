program printdate

character(len=8) :: today
character(len=10) :: now
character(len=8) :: zone
integer :: i,values(8)

call date8(today,now)

print*,today
print*,now



call date_and_time(today, now, zone,values)

do i=1,8
print*,i,values(i)
enddo


end program printdate


subroutine date8(date,time)
character(len=8) :: date
character(len=10) :: time
call date_and_time(date,time)
end subroutine date8
