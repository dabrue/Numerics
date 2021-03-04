program dot

implicit none

integer :: i, j ! hey these are integer 
double precision  :: A(5), B(5), Pi, C


pi=4.d0*atan(1.d0)





do i=1,5
    A(i)=i*Pi
    B(i)=i/Pi
enddo

forall(i=1:5) A(i)=i*Pi


C=Dot_Product(A,B)
print*,C
C=sum(A/B)
print*,C, 5*Pi**2
C=product(A)
print*,C
end


