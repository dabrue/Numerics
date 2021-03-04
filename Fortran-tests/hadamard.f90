program hadamard
implicit none

integer, allocatable :: H(:,:)

integer, parameter :: order=12

integer :: n, i, j, k, l, p, q, s
 
character(len=15) :: outfmt
character(len=5) :: ncol

n=2**order

write(ncol, fmt="(I5)") n
outfmt="("//trim(ncol)//"(I2,2x))"

allocate(H(n,n))

H=0

do i=1,n
   do j=1,n
      k=n
      s=1
      p=i
      q=j
      do l=1,order
         k=k/2
         if ( p > k .and. q <= k) s=s*-1 
         if ( p > k) p=p-k
         if ( q > k) q=q-k
      enddo
      if (s < 1 ) then 
         H(i,j)=-1
      else 
         H(i,j)=1
      endif
   enddo
enddo

open(unit=13,file="hadamard.txt")
do i=1, n
   write(13,fmt=outfmt) (H(i,j), j=1,n)
enddo

end


