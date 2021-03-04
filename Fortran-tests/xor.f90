program xor_test
implicit none


integer :: i, j, k, l


i = 11
j = 1

!k = (i.xor.j) ! this is deprecated method, for backward compatability
k = xor(i,j)  ! This is the preferred method

print*, k 

end
