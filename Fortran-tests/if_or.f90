program if_or
implicit none

! checks arguments of if to see if all are evaluated even after one fails

integer :: f, k 
double precision :: X(2)

do k=1,10

    if (k==5 .and. f(k) == 1) then
        print*,"k=",k
    endif
enddo


end program if_or

function f(k)
integer :: f, k
double precision :: X(2)


if (k== 5) then
    f = 1
else
    f=0
endif
print*,"ENTER FUNCTION ON k=",k, "f=",f

return

end function f
