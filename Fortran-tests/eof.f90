program endoffiletest
implicit none

integer :: i, j, stat
double precision :: x,y

!do i=1,300
!call random_number(x)
!write(170,*) x
!enddo

j=-1

open(11,file="readdata")
do while (stat.ne.-1)
read(11,*,iostat=stat) y
j=j+1
print*,j
enddo
print*,j


end
