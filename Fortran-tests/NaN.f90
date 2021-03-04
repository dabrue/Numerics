program nan
implicit none

! not a number test

double precision :: x, y, z, a(3)


x = 0.d0/0.d0  ! will this produce NaN?
! Yes!
print*,x

if (x /= x) then
    print*,"X is not a number"
endif

a=0.d0

! does this work for arrays?

!if (a /= a) then
        ! can this be done at all?
        !no
if (a(1) /= a(1) .or. a(2)/=a(2) .or. a(3) /= a(3)) then
    print*,"blah"
else
    print*,"blarg"
endif

end
