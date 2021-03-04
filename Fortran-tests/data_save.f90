program datasave
implicit none

integer :: i, j, k ,l
integer :: a, b, c, d



a=1
b=2
c=3

do i=1,10
call savesub(i, b, c)
enddo

end 


subroutine savesub(a, b, c)

integer :: a, b, c
integer :: d, e, f
integer, allocatable :: array(:)

save :: d, e, f, array

! DATA STATEMENTS ONLY INITIALIZE, WITH REPEATED CALLS, 
! SINCE D IS IN THE SAVE LIST, IT KEEPS IT'S PREVIOUS 
! VALUE
data d /0/, e/1/, f/2/

if (.not.allocated(array)) allocate(array(3))

print*,array(1),array(2),array(3)

array(1)=1+a
array(2)=2+a
array(3)=3+a

! GOOD, ONCE ALLOCATED AND INITIALIZED, THE ARRAY KEEPS IT'S VALUES


!print*,d
d=a+b+c
!print*,d
print*,array(1),array(2),array(3)

end subroutine savesub
