subroutine reduce_points(npts,nRpts,R,B,RR,RB)
!=========================================================================================
! reduce the number of points included in the fitting. 
! In this trial case, reduce to the nRpts that have the highest second derivative
! (in absolute value)
!
! D. A. Brue 2011
!=========================================================================================

use numeric_kinds

implicit none

integer :: i, j, k, l

integer, intent(in) :: npts, nRpts
real(wp_kind), intent(in) :: R(npts), B(npts)
real(wp_kind), intent(out) :: RR(nRpts), RB(nRpts)

real(wp_kind) :: Bpp(npts)  ! stores the second derivative

real(wp_kind) :: dr

dr=R(2)-R(1)


Bpp = zero

do i=2,npts-2
    Bpp(i)=(B(i-2)-2*B(i)+B(i+2))/(4*dr**2)
enddo

