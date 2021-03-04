program integerlimits

integer, parameter :: i1_kind = selected_int_kind(2)  ! -128, 127
integer, parameter :: i2_kind = selected_int_kind(4)  ! 
integer, parameter :: i4_kind = selected_int_kind(9)
integer, parameter :: i8_kind = selected_int_kind(12)


integer :: test1
integer(i2_kind) :: test2
integer(i4_kind) :: test4
integer(i8_kind) :: test8


test1=9223372036854775805
do while (.True.)
    test1=test1+1
    print*,test1
enddo

end program integerlimits
