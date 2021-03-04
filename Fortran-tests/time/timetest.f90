program timetest
implicit none

character(len=10) :: date, time, zone
integer :: i, j, k
integer :: now(3)
integer :: today(3)
integer :: values(8)


!call date_and_time(date,time,zone,values)
call date_and_time(date,time,zone,values)

print*,"date=",date
print*,"time=",time
print*,"zone=",zone
print*,"Values="
do i=1,8
   print*,i,values(i)
enddo

end
