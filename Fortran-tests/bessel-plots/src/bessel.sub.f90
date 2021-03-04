subroutine bessel(r,numpts,L,sl,cl)
! THIS SUBROUTINE CALCULATES THE DISCRETIZED BESSEL FUNCTION VALUES FOR 
! USE IN MATCHING THE WAVE FUNCTION TO THEM
implicit none
integer, parameter :: dp=selected_real_kind(14,300)
integer :: i, j, l
integer :: Eint
integer :: numpts
real (kind=dp) :: E, k
real (kind=dp) :: r(numpts), sl(100,numpts), cl(100,numpts)


! CALCULATE BESSEL FOR ANGULAR MOMENTUM OF ZERO
do i=1, numpts
   sl(1,i)=sin(r(i))
   cl(1,i)=cos(r(i))
enddo



! CALCULATE BESSEL FOR ANGULAR MOMENTUM OF 1
do i=2, numpts
   sl(2,i)=sin(r(i))/(r(i))-cos(r(i))
   cl(2,i)=cos(r(i))/(r(i))+sin(r(i))
enddo


! CALCULATE BESSEL FOR ANGULAR MOMENTUM OF 2 OR GREATER
! THESE CALCULATIONS COME FROM THE RECURSION RELATION, WHICH
! IS THE RESULT OF THE INDICIAL EQUATION. THE VALUES FOR L=1,2
! MUST BE DEFINED FIRST, HENCE THE ABOVE LINES. 
if (l.ge.2) then
   do j=1, l+1
      do i=2, numpts
         sl(j+2,i)= ((2.0d0*j + 1.0d0)*sl(j+1,i)/(r(i)))-sl(j,i)
         cl(j+2,i)= ((2.0d0*j + 1.0d0)*cl(j+1,i)/(r(i)))-cl(j,i)
      enddo
   enddo
endif

return
end
