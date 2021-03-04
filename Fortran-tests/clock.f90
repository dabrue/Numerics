program clock
implicit none
integer :: i, j, k, l
integer ::  ternspeed
integer :: time1,time2,timemax
integer :: huge0
integer :: systemspeed

huge0=huge(0)

systemspeed=2995

! CALL FOR SYSTEM TIME
call system_clock(time1, ternspeed, huge0)

! DO SOMETHING TO CAUSE DELAY
do i=1, 100000
j=3*i
k=4*i
l=j*k
enddo

! CALL SYSTEM TIME AGAIN
call system_clock(time2, ternspeed, huge0)

! PRINT THE TIME DIFFERENCE
print*, (time2-time1)

end
