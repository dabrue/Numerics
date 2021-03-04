program usigninttest
! Turns out this doesn't actually work, 
! There is not an unsigned type
implicit none

integer, parameter :: i8_kind = selected_int_kind(12)
integer(kind=i8_kind) :: A


A = 10**18

print*, A

end
