program truth
implicit none

! This program is to practice truth tables and see what equates to what


integer :: p


p=0
call outp(p)
p=1
call outp(p)
p=2
call outp(p)
p=3
call outp(p)
p=4
call outp(p)
p=.true.
p=.true.
call outp(p)
p=.false.
call outp(p)
p="T"
call outp(p)
p="F"
call outp(p)

end


subroutine outp(p)
integer :: p

if (p) then
    print*,p, "is T"
else
    print*,p, "is F"
endif

end subroutine outp
