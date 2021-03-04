program aiexchange
implicit none
double precision :: A
character (len=2) :: ind
character (len=5) :: fiel='file_'
character (len=9) :: forma
character (len=7) :: fieldone
integer :: i

do i=1, 9
!if (i.lt.10) forma='(I1)'
!if (i.ge.10.and.i.lt.100) forma='(I2)'
write (ind,fmt='(I1)') i
fieldone= ind // fiel
print*,fieldone
fieldone="d"//fiel
print*,fieldone

enddo

A=5.9887d-2
print*,A
end

