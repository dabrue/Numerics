program allo

implicit none

integer*8 :: k8
integer :: i, j, k, l
integer :: nx, ny, nz
real, allocatable :: X(:),Y(:)
real, allocatable :: Z(:)

nx=300
ny=9000
nz=100000

do k8=10000,10000000000,10000
    print*,k8
    allocate(X(k8))
    deallocate(X)
enddo

end
