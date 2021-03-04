program logs
implicit none

integer, parameter :: dp=selected_real_kind(14,300)

complex(dp) :: Q
real(dp) :: M
real(dp) :: R
real(dp) :: phase1, phase2
real(dp) :: Amp


Q=(5.d0,3.d0)

Amp=sqrt(real(Q)*real(Q)+aimag(Q)*aimag(q))

R=aimag(log(Q/AMP))

M=atan(aimag(q)/real(q))

print*,Q
print*,M
print*,R



end


