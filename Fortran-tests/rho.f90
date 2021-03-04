program rhocheck
implicit none
double precision :: d, cross(3), rho(3), bigsa(2), bigsb(2),smallsa(2), smallsb(2), smallsc(2), bigsc(2)
double precision :: A(2), B(2), C(2)
integer :: p

!define scaling factor for equal masses
!assume all masses set equal to 1
d=Sqrt((1.d0/Sqrt(1.d0/3.d0))*(1.d0-1.d0/3.d0))

do p=1,11

!define points of the triangle
A(1)=0.d0
A(2)=0.d0
B(1)=10.d0
B(2)=0.d0
C(1)=p-1.d0
C(2)=1.d0

!define the small s vector
smallsa(1)=C(1)-B(1)
smallsa(2)=C(2)-B(2)
smallsb(1)=A(1)-C(1)
smallsb(2)=A(2)-C(2)
smallsc(1)=B(1)-A(1)
smallsc(2)=B(2)-A(2)

!define the large S vector
bigsa(1)=A(1)-(B(1)+C(1))/2.d0
bigsa(2)=A(2)-(B(2)+C(2))/2.d0
bigsb(1)=B(1)-(A(1)+C(1))/2.d0
bigsb(2)=B(2)-(A(2)+C(2))/2.d0
bigsc(1)=C(1)-(A(1)+B(1))/2.d0
bigsc(2)=C(2)-(A(2)+B(2))/2.d0

!Change to mass scaled Jacobi coordinates
bigsa=d*bigsa
smallsa=smallsa/d
bigsb=d*bigsb
smallsb=smallsb/d
bigsc=d*bigsc
smallsc=smallsc/d

!find the cross products
cross(1)=smallsa(1)*bigsa(2)-bigsa(1)*smallsa(2)
cross(2)=smallsb(1)*bigsb(2)-bigsb(1)*smallsb(2)
cross(3)=smallsc(1)*bigsc(2)-bigsc(1)*smallsc(2)

!find the rho values
rho(1)=sqrt(smallsa(1)*smallsa(1)+smallsa(2)*smallsa(2)+bigsa(1)*bigsa(1)+bigsa(2)*bigsa(2))
rho(2)=sqrt(smallsb(1)*smallsb(1)+smallsb(2)*smallsb(2)+bigsb(1)*bigsb(1)+bigsb(2)*bigsb(2))
rho(3)=sqrt(smallsc(1)*smallsc(1)+smallsc(2)*smallsc(2)+bigsc(1)*bigsc(1)+bigsc(2)*bigsc(2))

!print results
print*,'C(1)=',C(1)
print*, 'cross products '
print*, cross(1), cross(2), cross(3)
print*, 'rho values'
print*, rho(1), rho(2), rho(3)
enddo

end
