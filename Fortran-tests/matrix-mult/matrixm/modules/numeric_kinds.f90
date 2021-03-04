module numeric_kinds
integer, parameter :: i1_kind = selected_int_kind(2)  ! -128, 127
integer, parameter :: i2_kind = selected_int_kind(4)  ! 
integer, parameter :: i4_kind = selected_int_kind(9)

integer, parameter :: sp_kind = selected_real_kind(p=6,r=30)    ! single precision
integer, parameter :: dp_kind = selected_real_kind(p=14,r=300)  ! double precision
integer, parameter :: qp_kind = selected_real_kind(p=25,r=1000) ! quadruple precision
end module numeric_kinds
