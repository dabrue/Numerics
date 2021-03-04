program foralltest
implicit none


integer :: i, j, k
integer :: A(10,10)


forall(i=1:10,j=1:10,(i/=j.and.i/=j-2)) A(i,j)=i*i*j


do i=1,10
    write(100,fmt="(10(I4,2x))") (A(i,j),j=1,10)
enddo

end
