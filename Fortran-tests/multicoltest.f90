program multicoltest
implicit none

integer :: i, j, k
integer :: ncol
character(len=20) :: colfmt
double precision :: A(3,30), x

ncol=31

do i=1,3
    do j=1,3
        A(i,j)=log(1.d0*i*j)
    enddo
    x=1.d0*i
enddo

do i=1,30
    do j=1,3
        if (A(j,i) /= A(j,i)) then
            print*,"nan found", j, i
        endif
    enddo
enddo

call multicolfmt(ncol+1,"dp",colfmt)
print *,colfmt

write(60,fmt=colfmt) x, ((A(i,j),i=1,j),j=1,ncol)

end
