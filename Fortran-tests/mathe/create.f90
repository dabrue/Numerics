program create
implicit none

double precision :: A(2,2)



open(unit=10, file='data')

A(1,1)=1.d0
A(2,1)=2.d0
A(1,2)=2.d0
A(2,2)=4.d0

write(10,*) A

end
