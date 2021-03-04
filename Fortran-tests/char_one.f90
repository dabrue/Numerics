program char_one
implicit none
integer :: i
character(Len=1) :: a, b
character(len=10) :: s


s="1234567890"

do i=1,10
read(s,"(A1,A1)") a, b
print*,a,b
enddo

end
