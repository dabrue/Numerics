program invert
use numeric_kinds_module
implicit none

real(dp) :: a(9,9), b(9,9), c(9,9), d(9,9)
real(dp) :: e(9,9), f(9,9), g(9,9), h(9,9)
real(dp) :: M(9,9),O(9,9)

logical :: sym
integer :: i,j,k,l,p,q
integer :: nuneq, nuneq2
integer :: mateq, mateq2
integer :: nmateq, nmateq2
integer :: nmat
integer :: nchk
integer :: rstat
real(dp) :: p1,p2
real(dp) :: limit
open (unit=900, file='matrices1',form='unformatted')

!do i=1,1185
do l=1,2
if( l== 1) limit = 1.d-10
if( l== 2) limit = 1.d100
nuneq=0
nuneq2=0
nchk=0
nmateq=0
nmateq2=0
nmat=0
do i=1,5332
   read(900,iostat=rstat) a
   if(rstat /=0) exit
   read(900,iostat=rstat) b
   if(rstat /=0) exit
! FORCE SYMMETRIC
   do j=1,9
   do k=1,9
      a(j,k)=a(k,j)
      b(j,k)=b(k,j)
   enddo
   enddo
   nmat=nmat+2
   c=a
   d=b
   e=a
   f=b
   g=c
   h=d
   M=c
   call smxinv(a,9)
   call smxinv(b,9)
   call smxinv2(c,9)
   call smxinv2(d,9)
   O=c
   e=matmul(e,a)
   f=matmul(f,b)
   g=matmul(g,c)
   h=matmul(h,d)

   mateq=nuneq
   mateq2=nuneq2
   do k=2,9
     do j=1,k-1
       if(i /= j) nchk=nchk+1
       if(e(i,j) > limit .and. i /= j) nuneq=nuneq+1 
       if(f(i,j) > limit .and. i /= j) nuneq=nuneq+1 
       if(g(i,j) > limit .and. i .ne. j) nuneq2=nuneq2+1 
      ! if(h(i,j) > limit .and. i /= j) nuneq2=nuneq2+1 
     enddo
  enddo
  if (mateq == nuneq) nmateq=nmateq+1 
  if (mateq2 == nuneq2) nmateq2=nmateq2+1 
  if (mateq2 /= nuneq2) then
     call mxoutdb(M,9,9,200)
     call mxoutdb(O,9,9,300)
     do p=1,9
     do q=1,p
        print*,O(p,q),O(q,p)
     enddo
     enddo
     call mxoutdb(matmul(M,O),9,9,400)
     exit
  endif
enddo
p1=(1.d2*nuneq)/(1.d0*nchk)
p2=(1.d2*nuneq2)/(1.d0*nchk)
print*,'limit =',limit
print*,'nchk   ',nchk
print*,'nuneq  ',nuneq,'%',p1
print*,'nmateq ',nmateq,'nmat',nmat
print*,'nuneq2 ',nuneq2,'%',p2
print*,'nmateq2',nmateq2,'nmat',nmat
print*,' '
rewind(900)
enddo

end
