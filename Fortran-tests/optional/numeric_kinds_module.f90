module numeric_kinds_module
implicit none
integer, parameter :: sp = kind(1.0)
integer, parameter :: dp = selected_real_kind(14,300)
end module numeric_kinds_module
