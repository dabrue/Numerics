program formats
implicit none
! this program in for the purpose of practicing format statements. 

character(len=4), parameter :: a2='(a2)'
character(len=2) :: che

 integer :: i, j, k
real*8 :: array(16)
real*8 :: pi

pi=4.d0*atan(1.d0)

che='la'

write(7,fmt=a2) che

do i=1,16
   array(i)=i*1.d0*pi
enddo

write(40,fmt="(16(F18.12, 3x))") pi,  (array(j), j=1,15)

end
