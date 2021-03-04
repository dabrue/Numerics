program format_tests
implicit none

character(len=30) :: outfmt
double precision :: pi


pi=4.d0*atan(1.d0)


outfmt="(ES18.12)"
print*,outfmt
write(6,fmt=outfmt) pi
print *,""

outfmt="(E18.12)"
print*,outfmt
write(6,fmt=outfmt) pi
print *,""

outfmt="(F18.12)"
print*,outfmt
write(6,fmt=outfmt) pi
print *,""

outfmt="(ES18.12)"
print*,outfmt
write(6,fmt=outfmt) -pi
print *,""

outfmt="(E18.12)"
print*,outfmt
write(6,fmt=outfmt) -pi
print *,""

outfmt="(F18.12)"
print*,outfmt
write(6,fmt=outfmt) -pi
print *,""


end
