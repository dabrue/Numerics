module numeric_kinds_module
implicit none
integer, parameter :: dp=selected_real_kind(14,300)
integer, parameter :: sp=kind(1.0)
end module numeric_kinds_module
