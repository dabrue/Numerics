program matmul1
implicit none

integer :: i, j, k, l

integer :: n

integer :: timei(8), timef(8)

double precision , allocatable :: A(:,:), B(:,:), C(:,:)

character(len=14) :: date,time,zone, tdiff


n=1200

allocate(A(n,n),B(n,n),C(n,n))


do i=1,n
    do j=1,n
        A(i,j)=1.d-1*i*j
        B(i,j)=1.d0/(i+j)
    enddo
enddo

call date_and_time(date,time,zone,timei)

C=matmul(A,B)

call date_and_time(date,time,zone,timef)


call elapsed_time(timei,timef,tdiff)

print*,n,tdiff


end
