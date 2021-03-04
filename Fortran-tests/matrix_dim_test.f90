program matrix_dim_test
! The purpose is to see how exactly to write parts of a matrix, and whether
! smaller parts of a matrix can be sent in subroutines. 


integer :: i, j, k, l, p, q
double precision :: A(5,5)
double precision :: D(5,5)
double precision :: B(3,3), C(3,3)
double precision :: pi

pi=4.d0*atan(1.d0)

do i=1,3
    do j=1,3
        B(j,i)=i*pi+j
        C(j,i)=j*pi+i
    enddo
enddo

A=0.d0

i=1
j=3
A(i:j,i:j)=matmul(C,B)


! this was accepted. Now, does it work for subroutines?

i=1
j=3
call blah(c,b,d(i:j,i:j))
write(100,*) A
write(101,*) D

do i=1,5
    do j=1,5
        if (A(j,i) /= D(j,i)) then
            print*,"FAIL", j, i
            print*,"FAIL",A(j,i),D(j,i)
        endif
    enddo
enddo
end 

subroutine blah(c, b, d)

double precision :: c(3,3)
double precision :: b(3,3)
double precision :: d(3,3)

pi=4.d0*atan(1.d0)

do i=1,3
    do j=1,3
        B(j,i)=i*pi+j
        C(j,i)=j*pi+i
    enddo
enddo

d=0.d0

d(i:j,p:q)=matmul(C,B)


end
