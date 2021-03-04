program format2
implicit none

character (len=3) :: l3

integer :: i, j, k


do i=1,100
   if (i < 10 ) write(l3,'("00",I1)') i
   if (i >= 10 .and. i < 100 ) write(l3,'("0",I2)') i
   if (i >= 100 ) write(l3,'(I3)') i
   print*,l3
enddo

do i=1,100
   

end
