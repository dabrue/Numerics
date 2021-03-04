program renametest
implicit none


integer :: i, j, k
character(80) :: renamefile
character(80) :: renamedfile

renamefile= "/home/brue/Programming/Fortran/tests/run"
renamedfile= "/home/brue/Programming/Fortran/tests/run2"

!renamefile= "/home/brue/Programming/Fortran/tests/renamefile"
!renamedfile= "/home/brue/Programming/Fortran/tests/renamedfile"

print*,"moving "//renamefile
print*,"to     "//renamedfile

call rename(renamefile,renamedfile)

print*,k

end



