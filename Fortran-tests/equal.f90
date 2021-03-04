program equal
implicit none

! this is to check if two entire arrays can be compared. 
! no, doesn't work, won't compile. 

real :: A(3,3)
real :: B(3,3)
integer :: i, j



do i=1,3
	do j=1,3
		A(i,j)=i+j
		B(i,j)=i+j
	enddo
enddo

if (A==B) then
	print*,"They are equal"
else
	print*,"They are not equal"
endif


do i=1,3
	do j=1,3
		A(i,j)=i+j
		B(i,j)=i*j
	enddo
enddo

if (A==B) then
	print*,"They are equal"
else
	print*,"They are not equal"
endif

end
