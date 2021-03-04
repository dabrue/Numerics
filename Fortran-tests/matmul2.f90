program matmul2
implicit none


double precision :: a(2,2), b(2,2), c(2,2)


a(1,1)=1
a(1,2)=1
a(2,1)=-1
a(2,2)=1

b(1,1)=0
b(1,2)=-1
b(2,1)=5
b(2,2)=2


c=matmul(a,b)

print*,c(1,1), c(1,2)
print*,c(2,1), c(2,2)



end
