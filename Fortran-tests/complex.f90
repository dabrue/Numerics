program complextest

integer, parameter :: dp=selected_real_kind(14,300)
Complex p,d,q,r,s,t
complex(dp) :: A(3,3)

p=(3.0,0.0)
d=(2.0,0.0)
q=p+d
r=p-d
s=p*d
t=p/d
print*,p,d,q
print*,r,s,t

A=(1.d0,5.d0)

write(14,*) dp, dp, A(1,1)
end
