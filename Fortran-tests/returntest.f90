program returntest
implicit none


integer :: i, j, k, l

do i=1,10
    print*,i
enddo

print*,'calling'

call testsub(i)

print*,'back now'

end program 
!=========================================================================================
subroutine testsub(i)
integer :: i
if (i > 4) then
    return
else
    print*,"i<4"
endif
print*,"after return, but still in subroutine"
end 
