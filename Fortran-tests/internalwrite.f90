program internalwrite
implicit none


character(len=5) :: chr
integer :: i


i=1

if (i < 10) then
    write(chr,"('0000',I1)") i
endif

print*,chr

end
