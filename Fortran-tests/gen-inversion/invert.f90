program invert
implicit none

! Testing the inverse of a general matrix lapack routine
integer :: ipiv,info
integer :: i, j
double precision :: A(2,4), B(2,4)
double precision :: work(20)


A(1,1)=1.d0
A(1,2)=2.d0
A(1,3)=3.d0
A(1,4)=5.d0
A(2,1)=7.d0
A(2,2)=11.d0
A(2,3)=13.d0
A(2,4)=17.d0

B=A
! LU FACTORIZE A
call dgetrf(2,4,A,2,ipiv,info)

call dgetri(2,A,2,ipiv,work,20,info)

print*,A
do i=1,2
   do j=1,4
     print*, A(i,j),B(i,j)
   enddo
enddo
end
