subroutine mxoutdb (a, nrow, ncol,nfile)
implicit none
integer :: nrow, ncol, irow, jcol
integer :: nfile
real*8 a(nrow,ncol)

irow = 1
!if(nrow.gt.10.and.ncol.gt.10)then
!   write(out_unit,*)'Printing 10 by 10 block of ',ncol,' by ',nrow,'   Matrix'
!end if
!write(out_unit,230)(jcol=1,min(ncol,10))
write(nfile,240)(a(1,jcol),jcol=1,min(ncol,10)) 
do irow = 2, min(nrow,10)
   write(nfile,240)(a(irow,jcol),jcol=1,min(ncol,10))
end do
 230  format (1h0, 3x, 8h  row   , 10(3x, i3, 6x))
! 240  format (1h , 1x, 4hcol , i3, 2x, 10(1pe12.4))
 240  format (2x, 10(1pe12.4))
 250  format (1h0, 1x, 4hcol , i3, 2x, 10(1pe12.4))
 end subroutine mxoutdb
