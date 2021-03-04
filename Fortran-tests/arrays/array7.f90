program array7
implicit none


double precision :: A(3), B(3)
double precision :: C(10)


A(1)=1.d0
A(2)=2.d0
A(3)=3.d0

C=20.d0

B=2.d0

A=A*B

print*,A

B=C(:3)

print*,B

end
