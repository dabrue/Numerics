program readbool
implicit none
! tests if I can read and write boolean values
integer :: i, j, k
logical :: test(3)

open(unit=12,file="readbool.dat")

test(1)=.false.
test(2)=.false.
test(3)=.false.

write(12,*) "T"
write(12,*) "1"
write(12,*) ".true."

rewind(12)

read(12,*) test(1)
read(12,*) test(2)
read(12,*) test(3)

if (test(1)) then
     print*,"T is true"  
else
    print *,"T is false"
endif

if (test(3)) then
     print*,"1 is true"  
else
    print *,"1 is false"
endif

if (test(3)) then
     print*,".true. is true"  
else
    print *,".true. is false"
endif

end

