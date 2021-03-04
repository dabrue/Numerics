program matmul_time
implicit none

! time the matmul routine

integer :: i, j, k
double precision :: M(2000,6000)
double precision :: A(6000),B(6000),C(6000)
double precision :: P(2000),Q(2000),R(2000)

do j=1,6000
    do i=1,2000
        M(i,j)=i*j/(i+j)
    enddo
    A(j)=j*1.d0
    B(j)=j*2.d0
    C(j)=j/2.d0
enddo

do k=1,100
    P=matmul(M,A)
    Q=matmul(M,B)
    R=matmul(M,C)
enddo

end



