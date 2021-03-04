program func
implicit none

double precision :: x(10),y(10),z(10),foo
integer :: p, q, foo2

do p=1,10
x(p)=p*1.3532d0
enddo

do p=1,10
y(p)=p*43.245
enddo

do p=1,10
z(p)=foo(x(p),y(p))
print*, z(p)
enddo

! OK, NOW CAN FUNCTIONS CHANGE THE VALUES OF THEIR ARGUMENTS?

p=0
q=2
print*,"before: p=",p,"q=",q
p=foo2(q)
print*,"after p=",p,"q=",q


! YES, THE FUNCTION CAN CHANGE THE ARGUMENT AS WELL. 
end

function foo(x,y)
double precision :: foo, x, y

foo=x*y
return

end function foo


function foo2(q)
integer :: foo2, q

foo2=q
q=4

return
end
