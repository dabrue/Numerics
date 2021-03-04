program dotproduct
implicit none


real :: A(4), B(4), C(4)
integer :: i, j, k


do i=1,4
    A(i)=i*1.d0
    B(i)=1.d0/i
enddo

C=dot_product(A,B)

do i=1,4
    print*,A(i),B(i),C(i)
enddo

C=A*B
do i=1,4
    print*,A(i),B(i),C(i)
enddo

end program
