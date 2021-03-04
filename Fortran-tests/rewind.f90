program rwnd
implicit none

! the purpose of this test program is to check how the 
! rewind command functions. 

! Under reading, one would expect that a field on the 
! first line can be read again after the rewind command
! has been issued. What about writing?

integer :: i, k
character(len=8) :: fiel

fiel="tmp     "

open(unit=12,file=fiel)

do i=1,100
    write(12,*) i
enddo

! now there is a file called whatever fiel is set to that contains
! a list of 1 to 100. What if I rewind it and continue writing?

rewind(12)

do i=101,200
   write(12,*) i
enddo


close(12)

! now go look at the file
! rewinding then writing will overwrite the data that is already there. 
! is there a way to insert it instead???


end
