program dir
implicit none

character(len=15) :: filename
logical :: there



filename = "tdir/testfile"

inquire( file = "tdir" ,exist = there) 

if (.not.there) then
    call system('mkdir tdir')
endif
print*,"status is ", there

open(unit=12,file=filename)

write(12,*) filename

end
