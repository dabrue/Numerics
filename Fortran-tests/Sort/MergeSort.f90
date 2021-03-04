module MergeSort
!-----------------------------------------------------------------------------------------
! Use von Neumann's Merge Sort algorithm to sort the columns of the given two
! dimensional rownow by the values in its rows. The data is sorted with the first
! row as the primary sort, the second row as the secondary, and so on. 
!
! On output, the array will have reordered columnds (but not rows), such that
! the element of each row are in ascending order, with precidence given to the
! first row, then second, and so on. 
!
! Merge sort is a "stable" algorithm, which means that entries that are
! eqivalent will not change order. This is important for sorting by multiple
! criteria. If we have 3 rows, the third row will be sorted first, then the
! second row, then the first row. The result is that the data is primarily
! sorted by the first row, then the second, then the third. 
!
! Example:
!
! On input:
! 5  5  1  3  3  3  2  4  3
! 1  2  1  1  2  1  1  1  1
! 3  4  1  2  4  5  6  7  4
!
! Will come out
! 1  2  3  3  3  3  4  5  5
! 1  1  1  1  1  2  1  1  2
! 1  6  2  4  5  4  7  3  4
! 
!
! The input 2D rownow will be in-place replaced with a sorted version, in which
! the primary sort will be the first column, then the second, etc. It is thus
! expected that the data is passed to this routine in with the columns in the
! order that they are desired to be sorted in. 
!
! This routine requires numeric_kinds.f90 module, or some module named this that
! defines a variable called wp_kind which determines the real type as  returned 
! by the selected_real_kind() intrinsic function
!
! Daniel Brue 2009
!-----------------------------------------------------------------------------------------

INTERFACE Merge_Sort

    module procedure MergeSort_int, MergeSort_real

END INTERFACE Merge_Sort


contains


subroutine MergeSort_int(nrow, ncol, array)

implicit none

!-----------------------------------------------------------------------------------------
! INPUT/OUTPUT
integer, intent(in) :: nrow
integer, intent(in) :: ncol
integer, intent(inout) :: array(nrow, ncol)

!-----------------------------------------------------------------------------------------
! INTERNALS

integer :: i, j
integer :: irow, icol
integer :: tmp(nrow,ncol)
integer :: rownow(2,ncol)

!-----------------------------------------------------------------------------------------
do irow=nrow,1,-1  ! start at last row, bottom, and work up
    do icol=1,ncol
        rownow(1,icol)=array(irow,icol)
        rownow(2,icol)=icol  ! define column index, these will get moved around
    enddo

    call merge_sort_int(ncol,rownow)

    ! create new rownow with columns reordered according to indices in the second
    ! element of rownow
    do i=1,ncol
        j=rownow(2,i)
        tmp(:,i)=array(:,j)
    enddo
    array=tmp
enddo
end subroutine MergeSort_int

!-----------------------------------------------------------------------------------------

recursive subroutine merge_sort_int(n,rownow)
! Use von Neumann's Merge Sort algorithm to sort the given rownow of length n
! Here we asssume that rownow is a 2xN rownow. Array(1,i) are the values being
! sorted on, and rownow(2,i) is an index just going along for the ride, so that
! at the end we know how the rownow changed. 
implicit none

integer, intent(in) :: n
integer, intent(inout) :: rownow(2,n)
integer, allocatable :: tmpL(:,:)
integer, allocatable :: tmpR(:,:)
integer :: i, p, q
integer :: tmp

if (n<=1) then ! already sorted
    ! do nothing
else
    p=n/2
    q=n-p
    allocate(tmpL(2,p))
    allocate(tmpR(2,q))

    do i=1,p
        tmpL(:,i)=rownow(:,i)
    enddo

    call merge_sort_int(p,tmpL)

    do i=1,q
        tmpR(:,i)=rownow(:,i+p)
    enddo
    call merge_sort_int(q,tmpR)
    call merge_lr_int(p,tmpL,q,tmpR,n,rownow)

    deallocate(tmpR)
    deallocate(tmpL)

endif

end subroutine merge_sort_int

!-----------------------------------------------------------------------------------------

subroutine merge_lr_int(p,tmpL,q,tmpR,n,rownow)
implicit none
! Merge the left and right rownows
integer, intent(in) :: p
integer, intent(in) :: tmpL(2,p)
integer, intent(in) :: q
integer, intent(in) :: tmpR(2,q)
integer, intent(in) :: n
integer, intent(out) :: rownow(2,n)

integer :: il, ir, ia

il=1
ir=1
ia=1
do while (ia <= n)
    if (il > p) then
        rownow(1,ia)=tmpR(1,ir)
        rownow(2,ia)=tmpR(2,ir)
        ia=ia+1
        ir=ir+1
    else if (ir > q) then
        rownow(1,ia)=tmpL(1,il)
        rownow(2,ia)=tmpL(2,il)
        ia=ia+1
        il=il+1
    else if (tmpL(1,il) <= tmpR(1,ir)) then
        ! note that if they are the same, we take the left one. This is what
        ! makes this a "stable" sorting algorithm. Same values do not change
        ! places. 
        rownow(1,ia)=tmpL(1,il)
        rownow(2,ia)=tmpL(2,il)
        ia=ia+1
        il=il+1
    else 
        rownow(1,ia)=tmpR(1,ir)
        rownow(2,ia)=tmpR(2,ir)
        ia=ia+1
        ir=ir+1
    endif
end do

end subroutine merge_lr_int

!=========================================================================================
    
subroutine MergeSort_real(nrow, ncol, array)
use numeric_kinds
implicit none

! INPUT ----------------------------------------------------------------------------------
integer, intent(in) :: nrow
integer, intent(in) :: ncol

! IN/OUT ---------------------------------------------------------------------------------
real(wp_kind), intent(inout) :: array(nrow, ncol)

integer :: i, j
integer :: irow, icol
real(wp_kind) :: tmp(nrow,ncol)
real(wp_kind) :: rownow(2,ncol)

!-----------------------------------------------------------------------------------------
do irow=nrow,1,-1  ! start at last row, bottom, and work up
    do icol=1,ncol
        rownow(1,icol)=array(irow,icol)
        rownow(2,icol)=icol  ! define column index, these will get moved around
    enddo

    call merge_sort_real(ncol,rownow)

    ! create new rownow with columns reordered according to indices in the second
    ! element of rownow
    do i=1,ncol
        j=rownow(2,i)
        tmp(:,i)=array(:,j)
    enddo
    array=tmp
enddo
end subroutine MergeSort_real

!-----------------------------------------------------------------------------------------

recursive subroutine merge_sort_real(n,rownow)
! Use von Neumann's Merge Sort algorithm to sort the given rownow of length n
! Here we asssume that rownow is a 2xN rownow. Array(1,i) are the values being
! sorted on, and rownow(2,i) is an index just going along for the ride, so that
! at the end we know how the rownow changed. 
use numeric_kinds
implicit none

integer, intent(in) :: n
real(wp_kind), intent(inout) :: rownow(2,n)

real(wp_kind), allocatable :: tmpL(:,:)
real(wp_kind), allocatable :: tmpR(:,:)

integer :: i, p, q
integer :: tmp

if (n<=1) then ! already sorted
    ! do nothing
else
    p=n/2
    q=n-p
    allocate(tmpL(2,p))
    allocate(tmpR(2,q))

    do i=1,p
        tmpL(:,i)=rownow(:,i)
    enddo

    call merge_sort_real(p,tmpL)

    do i=1,q
        tmpR(:,i)=rownow(:,i+p)
    enddo
    call merge_sort_real(q,tmpR)
    call merge_lr_real(p,tmpL,q,tmpR,n,rownow)

    deallocate(tmpR)
    deallocate(tmpL)

endif

end subroutine merge_sort_real

!-----------------------------------------------------------------------------------------

subroutine merge_lr_real(p,tmpL,q,tmpR,n,rownow)
use numeric_kinds
implicit none
! Merge the left and right rownows
integer, intent(in) :: p
real(wp_kind), intent(in) :: tmpL(2,p)
integer, intent(in) :: q
real(wp_kind), intent(in) :: tmpR(2,q)
integer, intent(in) :: n
real(wp_kind), intent(out) :: rownow(2,n)

integer :: il, ir, ia

il=1
ir=1
ia=1
do while (ia <= n)
    if (il > p) then
        rownow(1,ia)=tmpR(1,ir)
        rownow(2,ia)=tmpR(2,ir)
        ia=ia+1
        ir=ir+1
    else if (ir > q) then
        rownow(1,ia)=tmpL(1,il)
        rownow(2,ia)=tmpL(2,il)
        ia=ia+1
        il=il+1
    else if (tmpL(1,il) <= tmpR(1,ir)) then
        ! note that if they are the same, we take the left one. This is what
        ! makes this a "stable" sorting algorithm. Same values do not change
        ! places. 
        rownow(1,ia)=tmpL(1,il)
        rownow(2,ia)=tmpL(2,il)
        ia=ia+1
        il=il+1
    else 
        rownow(1,ia)=tmpR(1,ir)
        rownow(2,ia)=tmpR(2,ir)
        ia=ia+1
        ir=ir+1
    endif
end do

end subroutine merge_lr_real

!=========================================================================================

end module MergeSort
