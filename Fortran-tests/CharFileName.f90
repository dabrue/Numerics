program charfilename
implicit none

character(len=8) :: filename

filename='file'


open(unit=14,file=filename//'.txt') 
write(14,*) "blah"

close(14)

end


