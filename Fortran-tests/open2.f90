program open2
implicit none


! try opening a file and then write to the file from a subroutine. 
! this test is written in attempt to fix an error in scattering codes

integer :: funit
funit=38
open(unit=funit,file='open2file')


call open2sub(funit)

print*,'done with writing'

end 


subroutine open2sub(fileunit)

integer :: fileunit

write(fileunit,*) "writing to file"

end subroutine open2sub
