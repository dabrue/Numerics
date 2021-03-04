module numeric_kinds
integer, parameter :: i1b = selected_int_kind(2)  ! single byte integer
integer, parameter :: i2b = selected_int_kind(4)  ! 
integer, parameter :: i4b = selected_int_kind(9)

integer, parameter :: sp = selected_real_kind(p=6,r=30)    ! single precision
integer, parameter :: dp = selected_real_kind(p=14,r=300)  ! double precision
integer, parameter :: qp = selected_real_kind(p=25,r=1000) ! quadruple precision
end module numeric_kinds
