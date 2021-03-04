program matmul4
! another test
implicit none

double precision :: A(50,5), B(5,5), C(50,3)



A=1.d0
B=2.d0
C=0.d0

C=matmul(A,B(:,3:5))

print*,C

end
