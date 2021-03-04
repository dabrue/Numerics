program test

implicit none
double precision :: x, y, tgamma
integer :: i, j


do i=1,10
    y=i
    x=tgamma(y)
    print*,y, x
enddo

end



