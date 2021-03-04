program main
use numeric_kinds_module
implicit none


interface
   subroutine alpha_beta_exp(r, coef, alpha, beta, v, dv, ddv)
   use numeric_kinds_module
   implicit none
   real(dp) :: r, coef, alpha, beta, v
   real(dp), optional :: dv, ddv
   end subroutine alpha_beta_exp
end interface
real(dp) :: r, c, a, b, v, fdev, sdev
   

r=10.d0
c=4.d0
a=1.d0
b=2.d0
v=0.d0
fdev=0.d0
sdev=0.d0

call alpha_beta_exp(r, c, a, b, v)

print*,"First call OK: v=",v

call alpha_beta_exp(r, c, a, b, v, fdev)

print*,"Second call OK: v=",v,"fdev=",fdev

call alpha_beta_exp(r,c,a,b,v,fdev,sdev)

print*,"Third call OK: v=",v,"fdev=",fdev,"sdev=",sdev

sdev=0.d0
call alpha_beta_exp(r,c,a,b,v,ddv=sdev)

print*,"Fourth Call OK: sdev=",sdev

end


