program chararray
implicit none
character(len=4) :: car(5)
integer :: i


car(1)="one "
car(2)="two "
car(3)="thre"
car(4)="four"
car(5)="five"

do i=1,5
print*,car(i)
enddo

end


