program testkinds
implicit none

integer, parameter :: sp_kind=selected_real_kind(6,30)
integer, parameter :: dp_kind=selected_real_kind(14,300)
integer, parameter :: qp_kind=selected_real_kind(30,4000)
integer, parameter :: wp_kind=dp_kind

real(kind=wp_kind) :: two

two=2.0e2_wp_kind

print*,'sp_kind=',sp_kind
print*,'dp_kind=',dp_kind
print*,'qp_kind=',qp_kind

print*,'two    =',two


end 
