program delete_file_test

integer :: i, j, k, l


fiel = 12

open(unit=fiel,file='ablah')
i=1
write(fiel,*) i

close(fiel,status='DELETE')

end
