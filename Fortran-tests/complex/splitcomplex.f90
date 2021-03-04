program splitcomplex
implicit none

integer, parameter :: dp=selected_real_kind(14,300)
complex(kind=dp) :: A, B, IMG

real(kind=dp) :: R, I

A=(2.d0,5.d0)

IMG=(0.d0,1.d0)

R=DBLE(A)
B=A*IMG
I=-DBLE(B)

print*,"A=",A
print*,"R=",R
print*,"I=",I


end
