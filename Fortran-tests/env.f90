program env
implicit none
! the purpose of this test program is to learn how to use
! command line arguments as well as requesting environment
! variables. 


integer :: i, j, k, l
integer :: Narg
character(len=100) :: pwd
character(len=500) :: ld
character(len=13) :: arg1, arg2


Narg=iargc()
call getarg(1,arg1)
call getarg(2,arg2)

call getenv('PWD', pwd)
call getenv('LD_LIBRARY_PATH', ld)


print*,arg1," ",arg2
print*, pwd
print*, ld


end
