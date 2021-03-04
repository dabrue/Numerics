program newline

implicit none

! how does one write a newline in fortran? 

open(unit=12,file='testout')

write(12,fmt='(/)')
write(12,*) "blah"

end
