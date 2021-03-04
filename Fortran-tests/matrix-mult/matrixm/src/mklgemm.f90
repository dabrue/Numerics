program mklgemm
use numeric_kinds
implicit none

integer,parameter :: lda = 100
character(1) :: opa, opb
real(dp_kind), parameter :: one=1.d0
real(dp_kind), parameter :: two=2.d0
real(dp_kind) :: mata(lda,lda), matb(lda,lda), matc(lda,lda), matd(lda,lda)

mata=1.d0
matb=2.d0

opa="n"
opb="n"

matc=matmul(mata,matb)

!call gemm(mata,matb,matc)
call dgemm(opa,opb,lda,lda,lda,one,mata,lda,matb,lda,matc,lda)



end

