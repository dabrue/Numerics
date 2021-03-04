program unform
! This tests how to open and write to an unformatted file
implicit none

double precision :: A(3)
integer :: i
character (len=11) :: unf
unf='unformatted'
A=0.d0
A(3)=4.532423
A(2)=9.234
A(1)=.023494582383


open (unit=10,file='uformout',form="unformatted")
write(10) A
close (unit=10)

call unformread


end


subroutine unformread
implicit none

double precision :: A(3)
integer :: i

open (unit=10,file='uformout',form="unformatted")

read(10 ) A
print*, A(1), A(2), A(3)

end subroutine unformread
