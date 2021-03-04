program closefile
implicit none

integer, parameter :: funit=20

! CAN YOU CLOSE A FILE THAT ISN'T OPEN?
close(unit=funit)

print*,'Still OK'

end
