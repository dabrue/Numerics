program memuse
implicit none
integer :: i
double precision,allocatable :: A(:)


do i=268369924,9999999999

allocate(A(i))

write(160,*) i

deallocate(A)
enddo



end
