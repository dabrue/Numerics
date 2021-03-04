program blah
implicit none !blah!



integer :: i, j, k
real*8 :: exp2
real*8 :: fact


exp2=1.d0
fact=1.d-100
do i=1,500
  exp2=exp2*2.d0
  fact=fact*i
  print*,i,exp2,fact
enddo

end

