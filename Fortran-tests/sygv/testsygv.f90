program testsygv
implicit none
! This program tests the dsygv program from lapack

integer :: i, j, k
integer :: n, lda, ldb
integer :: tdim, itype, info, lwork
character(len=1) :: jobz, uplo

double precision :: ham(2,2), ovlp(2,2)
double precision :: ham9(9,9), ovlp9(9,9)
double precision :: diffs(9,9)
double precision :: work(50), eig(9), eig2(2)
double precision :: w(2)

character(len=18) :: frm

frm="(9(ES22.15,2x))"

open(unit=12,file="HAM.dat",form='unformatted')
open(unit=13,file="OVLP.dat",form='unformatted')
open(unit=14,file="H.frm")
open(unit=15,file="O.frm")
read(12) ham9
read(13) ovlp9

do i=1,9
    write(unit=14,fmt=frm) (ham9(i,j),j=1,9)
    write(unit=15,fmt=frm) (ovlp9(i,j),j=1,9)
enddo

do i=1,9
    do j=1,9
        diffs(i,j)=Ham9(i,j)-Ham9(j,i)
    enddo
enddo
open(unit=16,file="diff")
do i=1,9
    write(unit=16,fmt=frm) (diffs(i,j),j=1,9)
enddo

do i=1,9
    do j=1,i
        Ham9(i,j)=Ham9(j,i)
        ovlp9(i,j)=ovlp9(j,i)
    enddo
enddo




jobz="V"
uplo="U"
itype=1
tdim=9
lwork=50

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

call dsygv(itype,jobz,uplo,n,HAM9,lda,OVLP9,ldb,eig,work,lwork,info)

print*,eig


print*,info

end















