program outorder
implicit none

character(len=1) :: ci, cj
integer :: i, j
character(len=5) :: mat(5,5)

do i=1,5
    write(ci,"(I1)") i
    do j=1,5
        write(cj,"(I1)") j
        mat(i,j)="("//ci//","//cj//")"
    enddo
enddo

open(unit=12,file="outorder.out")
write(12,fmt="(15(A5,1X))") ((mat(i,j),i=1,j),j=1,5)


end program outorder
        
