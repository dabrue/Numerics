program numerics
implicit none

! selected_int_kind(r) returns compiler-dependent integer value describing the type
! of integer that can represent all integer values between -10^R < n < 10^R

integer :: i
integer, parameter :: i1_kind = selected_int_kind(2)  ! -128, 127
integer, parameter :: i2_kind = selected_int_kind(4)  !
integer, parameter :: i4_kind = selected_int_kind(9)
integer, parameter :: i8_kind = selected_int_kind(12)

! selected_real_kind(p,r) returns compiler dependent integer value describing
! the type of real number that can express a number with p digits of precision
! and an exponent up to r
integer, parameter :: sp_kind = selected_real_kind(p=6,r=30)    ! single precision
integer, parameter :: dp_kind = selected_real_kind(p=14,r=300)  ! double precision
integer, parameter :: qp_kind = selected_real_kind(p=25,r=1000) ! quadruple precision

integer(kind=i1_kind) :: sprec, dprec, qprec

real(kind=sp_kind) :: sone
real(kind=sp_kind) :: seps, smax, smin, smaxex, sminex
real(kind=sp_kind) :: shuge, stiny
real(kind=dp_kind) :: done
real(kind=dp_kind) :: deps, dmax, dmin, dmaxex, dminex
real(kind=dp_kind) :: dhuge, dtiny
real(kind=qp_kind) :: qone
real(kind=qp_kind) :: qeps, qmax, qmin, qmaxex, qminex
real(kind=qp_kind) :: qhuge, qtiny

sone=1.0
done=1.d0
qone=1.q0

print*,"i1_kind=",i1_kind
print*,"i2_kind=",i2_kind
print*,"i4_kind=",i4_kind
print*,"i8_kind=",i8_kind

print*,"standard integer is ", kind(i)




! epsilon is smallest difference between two numbers for given precision
seps=epsilon(sone)
deps=epsilon(done)
qeps=epsilon(qone)
print*,"Epsilon"
print*,"S Precision Epsilon: ",seps
print*,"D Precision Epsilon: ",deps
print*,"Q Precision Epsilon: ",qeps
print*,""

! smallest possible exponent, i.e. closest to zero
sminex=minexponent(sone)
dminex=minexponent(done)
qminex=minexponent(qone)
print*,"Minimum Exponent"
print*,"S Min Exponent: ", sminex
print*,"D Min Exponent: ", dminex
print*,"Q Min Exponent: ", qminex
print*,""

! maximum exponent
smaxex=maxexponent(sone)
dmaxex=maxexponent(done)
qmaxex=maxexponent(qone)
print*,"Maximum Exponent"
print*,"S Max Exponent: ", smaxex
print*,"D Max Exponent: ", dmaxex
print*,"Q Max Exponent: ", qmaxex
print*,""

! smallest representable number, i.e. closest to zero
stiny=tiny(sone)
dtiny=tiny(done)
qtiny=tiny(qone)
print*,"Smallest possible number"
print*,"S Tiny: ", stiny
print*,"D Tiny: ", dtiny
print*,"Q Tiny: ", qtiny
print*,""

! largest representable number
shuge=huge(sone)
dhuge=huge(done)
qhuge=huge(qone)
print*,"Largest possible number"
print*,"S Huge: ", shuge
print*,"D Huge: ", dhuge
print*,"Q Huge: ", qhuge
print*,""

! number of digits of precision
sprec=precision(sone)
dprec=precision(done)
qprec=precision(qone)
print*,"Precision"
print*,"S Prec: ",sprec
print*,"D Prec: ",dprec
print*,"Q Prec: ",qprec

! Errors


end program numerics
    
