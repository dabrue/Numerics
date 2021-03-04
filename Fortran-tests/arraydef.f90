program arraydef

integer, parameter :: dp_kind = selected_real_kind(14,300)

integer :: i, j, k, l

real(dp_kind), parameter :: A(3)=(/ 1.d0, 2.d0, 3.d0 /)

integer, parameter :: M(3) = (/1, 2, 3/)


do i=1,3
    print*,M(i),A(i)
enddo

end
