program trapazoidal
implicit none

!this test program tests the accuracy of the trapazoidal integration 
! method for various step sizes

integer :: i, j, k, l
integer :: npts

real*8 :: xmin, xmax, pi, x, dx
real*8 :: vnow, vprev, intval


pi=4.d0*atan(1.d0)

xmin=-4.d0*pi
xmax=4.d0*pi


! try sine first. Since integrating whole wavelengths, this should be zero

do npts=100, 20000, 100
   dx=(xmax-xmin)/(npts*1.d0)
   do i=0,npts
      x=xmin+i*dx
      vnow=sin(x)
      if (i==0) then 
         vprev=vnow
      else
         intval=intval+0.5d0*(vnow+vprev)*dx
      endif
      vprev=vnow
   enddo
   print*, npts, intval
enddo


end
      
      
