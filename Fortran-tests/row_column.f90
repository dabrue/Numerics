program row_column
implicit none

integer :: i,j 

real :: a(2,2)
real :: b(2)

do i=1,2
    do j=1,2
        a(i,j)=i*i*j
    enddo
enddo

print *, a

b(1)=1
b(2)=-1

b=matmul(a,b)

print*,b

end


