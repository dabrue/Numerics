program factorial
implicit none
integer, parameter :: dp=selected_real_kind(14,300)
integer, parameter :: qp=selected_real_kind(30,900)

integer :: i, j, k, n
real(dp) :: fact, fact1
real(qp) :: fact2(10)

n=100
fact=1.d0
do i=1,n
    fact=fact*i
enddo
print*,fact

k=2*n-1
fact2=1.q0
fact1=1.d0
j=1
do i=1,k,2
    fact1=fact1*i
    fact2(j)=fact2(j)*i
!    if (fact2(j)>1.q100) j=j+1
enddo
do j=2,10
    fact2(1)=fact2(1)*fact2(j)
enddo
print*,fact1
print*,fact2(1)

end program
