module numeric_kinds_module
integer, parameter :: i1_kind = selected_int_kind(2)  ! -128, 127
integer, parameter :: i2_kind = selected_int_kind(4)  ! 
integer, parameter :: i4_kind = selected_int_kind(9)

integer, parameter :: sp_kind = selected_real_kind(p=6,r=30)    ! single precision
integer, parameter :: dp_kind = selected_real_kind(p=14,r=300)  ! double precision
integer, parameter :: qp_kind = selected_real_kind(p=25,r=1000) ! quadruple precision
integer, parameter :: wp_kind = dp_kind

real(kind=wp_kind), parameter :: zero   =  0.0_wp_kind
real(kind=wp_kind), parameter :: one    =  1.0_wp_kind
real(kind=wp_kind), parameter :: two    =  2.0_wp_kind
real(kind=wp_kind), parameter :: three  =  3.0_wp_kind
real(kind=wp_kind), parameter :: four   =  4.0_wp_kind
real(kind=wp_kind), parameter :: five   =  5.0_wp_kind
real(kind=wp_kind), parameter :: six    =  6.0_wp_kind
real(kind=wp_kind), parameter :: seven  =  7.0_wp_kind
real(kind=wp_kind), parameter :: eight  =  8.0_wp_kind
real(kind=wp_kind), parameter :: nine   =  9.0_wp_kind
real(kind=wp_kind), parameter :: ten    = 10.0_wp_kind
real(kind=wp_kind), parameter :: eleven = 11.0_wp_kind
real(kind=wp_kind), parameter :: twelve = 12.0_wp_kind

real(kind=wp_kind), parameter :: small  = tiny(one)
real(kind=wp_kind), parameter :: large  = huge(one)
 
real(kind=wp_kind), parameter :: half   = 0.50_wp_kind

end module numeric_kinds_module
