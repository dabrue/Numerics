module numeric_kinds_module
integer, parameter :: i1b = selected_int_kind(2)
integer, parameter :: i2b = selected_int_kind(4)
integer, parameter :: i4b = selected_int_kind(9)

integer, parameter :: sp = kind(1.0)
integer, parameter :: dp = selected_real_kind(14,300)

end module numeric_kinds_module
