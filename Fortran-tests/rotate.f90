program rotate
implicit none
double precision :: a, b, c, x1(3), x2(3), R(3,3), Rt(3,3)
integer :: p, q
print*, 'alpha'
read*, a
print*, 'beta'
read*,b
print*, 'gamma'
read*,c
x1(1)=1.d0
x1(2)=2.d0
x1(3)=3.d0
print*, x1(1), x1(2), x1(3)

R(1,1)=Cos(a)*Cos(b)*Cos(c)-Sin(a)*Sin(c)
R(1,2)=Sin(a)*Cos(b)*Cos(c)+Cos(a)*Sin(c)
R(1,3)=-Sin(b)*Cos(c)
R(2,1)=-Cos(a)*Cos(b)*Sin(c)-Sin(a)*Cos(c)
R(2,2)=-Sin(a)*Cos(b)*Sin(c)+Cos(a)*Cos(c)
R(2,3)=Sin(b)*Sin(c)
R(3,1)=Cos(a)*Sin(b)
R(3,2)=Sin(a)*Sin(b)
R(3,3)=Cos(b)

do p=1,3
   do q=1,3
      Rt(p,q)=R(q,p)
   enddo
enddo

x2=matmul(R,x1)

print*, 'rotated to'
print*, x2(1),x2(2),x2(3)

x1=matmul(Rt,x2)
print*, 'rotated back?'
print*, x1(1), x1(2), x1(3)

end

