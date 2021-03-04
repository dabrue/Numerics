program controlchar
implicit none


integer :: i, j, k, l

do i=1,10000000
k=i*i*i
l=i/100000
print*,"+","Done ",l," percent"
enddo

end
