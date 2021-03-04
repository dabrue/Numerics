program matlimits

implicit none
integer :: i, j
real :: a(4,4)
real :: b(2,2)

a=0.0e0
b=1.0e0

a(1:2,3:4)=b

do i=1,4
    write(*,*) (a(i,j),j=1,4)
enddo

end
