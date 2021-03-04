program args2
! This tests if iargc and getarg are available to subroutines

integer :: nargs


call parse 

end program

subroutine parse

integer :: nargs
integer :: I
character(len=40) :: arg

nargs=iargc()

do i=1,nargs
    call getarg(i,arg)
    print*,i,arg
enddo

end subroutine parse

