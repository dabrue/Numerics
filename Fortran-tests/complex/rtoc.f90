program rtoc
implicit none
integer, parameter :: dp=selected_real_kind(14,300)

integer :: j
real(dp) :: A, B, D
complex(dp) :: C, E

real(dp) :: M(3,3)
complex(dp) :: MI(3,3)
complex(dp) :: I(3,3)

I=0.d0
do j=1,3
I(j,j)=(1.d0,0.d0)
enddo

A=2.d0
B=3.d0
C=cmplx(a, b, dp)

print*,c
A=1.d0
B=5.d0
E=cmplx(a,b,dp)

print*,"C=",C
print*,"E=",E
print*,"C*E=",C*E
print*,""


D=real(c,dp)
print*,d

MI=(2.d0,3.d0)
M=REAL(MI,dp)


print*,M

M=-REAL(MI*(0.d0,1.d0), dp)
print*,MI

print*,"I-M"
print*,I-MI
print*,"I-iM"
print*,I-(0.d0,1.d0)*MI
print*,"I+iM"
print*,I+(0.d0,1.d0)*MI

end
