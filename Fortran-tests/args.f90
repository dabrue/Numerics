program args
implicit none

! THIS PROGRAM TESTS HOW TO GET COMMAND LINE ARGUMENTS. 
! IN THIS CASE, IT SIMPLY WRITES THEM BACK TO THE SCREEN WITH
! THE ARGUMENT'S ARGUMENT NUMBER

integer :: nargs, i
character(len=80) :: arg

nargs=iargc()
print*,'This was called with',nargs,' arguments'

do i=1,nargs
call getarg(i,arg)
print*,'Argument ',i,' is ',arg
enddo

end
