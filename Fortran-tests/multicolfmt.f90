subroutine multicolfmt(ncol,spdp,frmt)
implicit none

! this subroutine takes on input the argument ncol and returns
! a string containing a format to print ncolumns. 
! this string should be at least 18 characters in length if you're 
! printing a lot of columns.  

! Input: 
!	ncol - number of columns
! 	spdp - is "sp" if you want single precision output, "dp" if you want double precision
!
! Output:
!	frmt - String containing format

character*(*) :: spdp
character(len=3) :: n
character*(*) :: frmt
integer :: ncol
integer :: i


write(n,'(I3)') ncol

print*,"spdp=",spdp

if (spdp == "dp") then
   frmt="("//n//"(F15.12, 3x))"
else
   frmt=frmt // n // "(F10.7, 3x))"
endif

end subroutine multicolfmt
   
