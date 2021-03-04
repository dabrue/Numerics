program main
implicit none

integer :: a, b, c
integer :: z, y
double precision :: x
integer :: afunc
double precision :: xfunc

a=1
b=2
c=3

x=4.d0
y=5
z=6

a = afunc(b,c)
x = xfunc(y,z)


print*,a,b,c
print*,x,y,z


end

integer function afunc(x,y)
implicit none
integer :: x, y
afunc=x*y
end function afunc

double precision function xfunc(x,y)
implicit none
integer :: x, y
xfunc=(x+y)*1.d0
end function xfunc
