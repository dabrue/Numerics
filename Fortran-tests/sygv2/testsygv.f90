program testsygv
implicit none
! This program tests the dsygv program from lapack

integer :: i, j, k
integer :: n, lda, ldb
integer :: tdim, itype, info, lwork
integer :: iwork(500), liwork
character(len=1) :: jobz, uplo

double precision :: ham(2,2), ovlp(2,2)
double precision :: work(50),  eig(2)
double precision :: w(2)

character(len=18) :: frm

jobz="V"
uplo="U"
itype=1
tdim=2
lwork=50
liwork=500

Ham(1,1)=1
Ham(2,1)=1
Ham(1,2)=1
Ham(2,2)=2
ovlp(1,1)=1
ovlp(2,1)=0
ovlp(1,2)=0
ovlp(2,2)=1

n=tdim
lda=tdim
ldb=tdim

do i=1,tdim
    write(*,*) (ham(i,j),j=1,tdim)
    write(*,*) (ovlp(i,j),j=1,tdim)
enddo


!call dsyev(jobz,uplo,n,Ham,lda,eig,work,lwork,info)
call dsygv(itype,jobz,uplo,n,HAM,lda,OVLP,ldb,w,work,lwork,info)
!call dsygvd(itype,jobz,uplo,n,HAM,lda,OVLP,ldb,work,lwork,iwork,liwork,info)



print*,info

end















