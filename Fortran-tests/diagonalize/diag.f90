program diag
implicit none

! TEST DIAGONALIZATION LAPACK ROUTINES


integer :: i, j, k
integer :: n, info
double precision :: x(9,9) ! MATRIX TO BE DIAGONALIZED 
double precision :: w(9,9) ! WORK MATRIX FOR DIAGONALIZATION ROUTINE
double precision :: wr(9), wi(9)  ! IMAGINARY AND REAL PARTS OF EIGENVALUES
double precision :: vl(9,9) ! LEFT EIGENVECTORS
double precision :: vr(9,9) ! RIGHT EIGENVECTORS
double precision :: v(9,9) ! READ IN MATRIX

n=9

open(unit=40,file='Vatr65',form='unformatted')
read(40)V
close(40)

V=V!*8.d0
call dsyev('V','U',n,V,n,wr,w,30,info)

! X now contains the eigenvectors
! wr contains the eigenvalues

print*,V
w=matmul(V,transpose(V))
print*,''
print*,W
print*,''
print*,wr
end

