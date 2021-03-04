program etest
implicit none

character(len=10) :: date, time, zone
character(len=14) :: tdiff
integer :: tf(8), ti(8)

integer :: i, j, k
double precision :: x, y, z


call date_and_time(date,time,zone,ti)


! now do something to take up some time
do k=1,5
do i=1,1000000
print*,i
x=i*1.d0
y=log(x)
z=i*2.d0
y=log(x)
x=x*z
y=log(x)
x=y/z
y=log(x)
enddo
enddo

call date_and_time(date,time,zone,tf)

call elapsed_time(ti,tf,tdiff)
print*,"Time difference between calls is ", tdiff

end program etest
