module numeric_kinds
!=========================================================================================
! This module defines types and constants to be used throughout other codes. Here is 
! defined the real type wp_kind (working precision) that defines the real type of all
! declared real variables. 
!
! D. A. Brue
!=========================================================================================
implicit none

! Define compiler-dependent type constants as parameters
! selected_int_kind(R) returns kind that will allow for -2^R to 2^R
integer, parameter :: i1_kind = selected_int_kind(2)  ! -128, 127
integer, parameter :: i2_kind = selected_int_kind(4)  ! 
integer, parameter :: i4_kind = selected_int_kind(9)
integer, parameter :: i8_kind = selected_int_kind(12)

integer, parameter :: sp_kind = selected_real_kind(p=6,r=30)    ! single precision
integer, parameter :: dp_kind = selected_real_kind(p=14,r=300)  ! double precision
integer, parameter :: qp_kind = selected_real_kind(p=30,r=4000) ! quadruple precision
! note above real kind types also work for complex declarations

! Select real kind to be used throughout the rest of code
integer, parameter :: iw_kind = i4_kind
integer, parameter :: wp_kind = dp_kind

! Numbers  ===============================================================================
integer, parameter :: izero     = 0
integer, parameter :: ione      = 1
integer, parameter :: itwo      = 2
integer, parameter :: ithree    = 3
integer, parameter :: ifour     = 4
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
real(kind=wp_kind), parameter :: thirteen = 13.0_wp_kind
real(kind=wp_kind), parameter :: fourteen = 14.0_wp_kind
real(kind=wp_kind), parameter :: fifteen  = 15.0_wp_kind

! Fractions
real(kind=wp_kind), parameter :: half   = 0.50_wp_kind

! Common Reals
real(kind=wp_kind), parameter :: sqrt2=sqrt(two)
real(kind=wp_kind), parameter :: sqrt3=sqrt(three)
real(kind=wp_kind), parameter :: pi=four*atan(one)

real(kind=wp_kind), parameter :: two7 = 128.0_wp_kind
real(kind=wp_kind), parameter :: two8 = 256.0_wp_kind
real(kind=wp_kind), parameter :: two9 = 512.0_wp_kind
real(kind=wp_kind), parameter :: two10 = 1024.0_wp_kind
real(kind=wp_kind), parameter :: two11 = 2048.0_wp_kind
real(kind=wp_kind), parameter :: two12 = 4096.0_wp_kind
real(kind=wp_kind), parameter :: two13 = 8192.0_wp_kind
real(kind=wp_kind), parameter :: two14 = 16384.0_wp_kind
real(kind=wp_kind), parameter :: two15 = 32768.0_wp_kind
real(kind=wp_kind), parameter :: two16 = 65536.0_wp_kind
real(kind=wp_kind), parameter :: two17 = 131072.0_wp_kind
real(kind=wp_kind), parameter :: two18 = 262144.0_wp_kind
real(kind=wp_kind), parameter :: two19 = 524288.0_wp_kind
real(kind=wp_kind), parameter :: two20 = 1048576.0_wp_kind


! Numerics ===============================================================================
real(kind=wp_kind), parameter :: wp_tiny  = tiny(one)  ! smallest number
real(kind=wp_kind), parameter :: wp_huge  = huge(one)  ! largest number
real(kind=wp_kind), parameter :: wp_Epsilon= epsilon(one) ! smallest difference
integer, parameter :: wp_Prec   = precision(one)    ! number of digits of precision
integer, parameter :: wp_minexp = minexponent(one)  ! smallest exponent
integer, parameter :: wp_maxexp = maxexponent(one)  ! largest exponent
integer(kind=iw_kind), parameter :: iw_bit_size = bit_size(1_IW_kind) ! Number of bits
integer(kind=iw_kind), parameter :: iw_digits   = digits(1_iw_kind)   ! number of digits
integer(kind=iw_kind), parameter :: wp_digits   = digits(1.0_wp_kind) ! number of digits

end module numeric_kinds
