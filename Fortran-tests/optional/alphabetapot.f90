subroutine alpha_beta_exp(r, coef, alpha, beta,  v, dv, ddv)
use numeric_kinds_module
implicit none

!======================================================================
! Written by Daniel Brue, October 2005
! 
! Purpose
! To return the value and derivatives of the potential of the form:
!
! V = coef*exp(-alpha*r-beta*r*r)
! 
! Input:
! r : The value at which the potential/derivatives is desired
! coef : The leading coefficient of the potential
! alpha : The linear exponential coefficient
! beta : The quadratic exponential coefficient
!
! Output:
! v : the value of the potential at r
! dv : OPTIONAL! the first derivative of the potential at r
! ddv : OPTIONAL! the second derivative of the potential at r
!
! Optional Output:
! If dv and/or ddv are present in the argument list, the subroutine will
! return values for them
!
! N.B. If only one of either dv or ddv is present, the program assumes
! that the argument is dv unless specified in the calling program
! by 
! call alpha_beta_exp(r,c,a,b,v,ddv=seconddir)
! which requires knowing what this subroutine calls the variables
!
!=======================================================================

! LOGICAL VARIABLES
logical :: d1chk   ! CHECK IF FIRST DERIV VARIABLE HERE
logical :: d2chk   ! CHECK IF SECOND DERIV VARIABLE HERE

! DOUBLE PRECISION VARIABLES:
real(kind=dp) :: r
real(kind=dp) :: coef
real(kind=dp) :: alpha
real(kind=dp) :: beta
real(kind=dp) :: v
real(kind=dp),intent(inout), optional :: dv
real(kind=dp),intent(inout), optional :: ddv
real(kind=dp) :: tmpa, tmpb

!-----------------------------------------------------------------------
! CHECK FOR PRESENCE OF DERIVATIVE VARIABLES
d1chk=PRESENT(dv)
d2chk=PRESENT(ddv)

!-----------------------------------------------------------------------
! SET TEMP VARIABLES TO EASE CALCULATION LATER
tmpa=exp(-alpha*r)
tmpb=exp(-beta*r*r)

!-----------------------------------------------------------------------
! COMPUTE THE POTENTIAL VALUE
v=coef*tmpa*tmpb

!-----------------------------------------------------------------------
! COMPUTE THE POTENTIAL FIRST DERIVATIVE (OPTIONAL)
if (d1chk) then
   dv=coef*tmpa*tmpb*(-alpha-2.d0*beta*r)
endif

!-----------------------------------------------------------------------
! COMPUTE THE POTENTIAL SECOND DERIVATIVE (OPTIONAL)
if (d2chk) then
   ddv=coef*tmpa*tmpb*(alpha*alpha+4.d0*beta*beta*r*r+4.d0*alpha*beta*r)
endif

!-----------------------------------------------------------------------

end

