program dimensub
implicit none

integer :: i, j, k, l, m, n

double precision, allocatable :: F(:, :)


j=4
i=4
n=(j+1)*(i+1)

allocate(F(0:j,0:i))

do l=0,i
    do k=0,j
        F(k,l)=k+i*l
    enddo
enddo

call somesub(n,F)

end 


subroutine somesub(n,F)
integer, intent(in) :: n
integer :: i
double precision :: F(n)
do i=1,n
    print*,F(i)
enddo

end subroutine
