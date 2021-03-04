program fact2
implicit none

real*16 :: s, x
real*8  :: f
integer*8 :: i, j, k

x=1.q-100
k=171


j=1

f=1.q0
s=1.q0!*x

do i=1,k
   j=j*i
   f=f*i
   s=s*i
enddo

print*,f, s, j
end
