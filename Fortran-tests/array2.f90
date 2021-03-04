program array2
implicit none


real :: A(4,4), B(4), C(4,4)
integer :: i, j, k, l


! see if we can define b, then input it per row into a

do i=1,4
B(i)=i*1.d0
enddo

do j=1,4
A(j,:)=B
enddo

print*,A(1,1), A(1,2), A(1,3), A(1,4)
print*,A(2,1), A(2,2), A(2,3), A(2,4)
print*,A(3,1), A(3,2), A(3,3), A(3,4)
print*,A(4,1), A(4,2), A(4,3), A(4,4)

do j=1,4
A(:,j)=B
enddo

print*,""

print*,A(1,1), A(1,2), A(1,3), A(1,4)
print*,A(2,1), A(2,2), A(2,3), A(2,4)
print*,A(3,1), A(3,2), A(3,3), A(3,4)
print*,A(4,1), A(4,2), A(4,3), A(4,4)

C=0.d0
do i=1,4
   do j=1,4
      C(:,i)=j*A(j,i)+C(:,i)
   enddo
enddo

print*,C(1,1), C(1,2), C(1,3), C(1,4)
print*,C(2,1), C(2,2), C(2,3), C(2,4)
print*,C(3,1), C(3,2), C(3,3), C(3,4)
print*,C(4,1), C(4,2), C(4,3), C(4,4)

end

