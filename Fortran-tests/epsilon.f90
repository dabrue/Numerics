program eps
implicit none

real*4 :: seps
real*8 :: deps
real*16 :: qeps

seps=1.0
deps=1.0d0
qeps=1.0q0

print*,"SINGLE", epsilon(seps)
print*,"DOUBLE",epsilon(deps)
print*,"QUADPL",epsilon(qeps)


end
