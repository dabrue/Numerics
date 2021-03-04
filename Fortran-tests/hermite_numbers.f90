program hermite_numbers
implicit none

integer :: i, j, k, l
integer :: N
real*8 ::  wholefact, halffact
real*8, allocatable :: Hr(:), Hn(:)


n=100
allocate(Hr(0:n),Hn(0:n))

! recursive method
Hr=0.d0
Hr(0)=1.d0
Hr(2)=-2.d0

do i=4,n,2
   Hr(i)=-2.d0*(i-1)*Hr(i-2)
enddo


! direct method
wholefact=1.d0
halffact=1.d0
do i=0,n,2
   if (i>0) wholefact=wholefact*i*(i-1.d0)
   if (i>0) halffact=halffact*(i/2.d0)
   Hn(i)=(-1)**(i/2)*wholefact/halffact
enddo

do i=0,n,2
print*,Hr(i), Hn(i)
enddo

end

