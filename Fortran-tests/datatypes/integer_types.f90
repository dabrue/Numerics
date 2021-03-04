program integer_types
implicit none

integer :: h,i,j

! PRINT HEXIDECIMAL FORMAT
h=Z'F123'
j=Z'A45B'
! equals 1*256+2*16+3=291

print*,h

! CAN IT BE WRITTEN IN HEX?
write(*,fmt='(Z4)') h
! yes it can

! CAN IT BE WRITTEN IN BINARY?
write(*,fmt='(B16)') h

! CAN IT BE WRITTEN IN OCTAL?
write(*,fmt='(O12)')h

! CAN I DO BINARY OPERATIONS ON THIS NUMBER?
i=Not(h)

write(*,fmt='(Z4)')i

print*,' '
print*,'XOR'
i=XOr(h,j)
write(*,fmt='(B16,3x,Z4,3x,I10)') h,h,h
write(*,fmt='(B16,3x,Z4,3x,I10)') j,j,j
write(*,fmt='(B16,3x,Z4,3x,I10)') i,i,i

print*,' '
print*,'OR'

i=iOr(h,j)
write(*,fmt='(B16,3x,Z4,3x,I10)') h,h,h
write(*,fmt='(B16,3x,Z4,3x,I10)') j,j,j
write(*,fmt='(B16,3x,Z4,3x,I10)') i,i,i

print*,' '
print*,'AND'
i=iAnd(h,j)
write(*,fmt='(B16,3x,Z4,3x,I10)') h,h,h
write(*,fmt='(B16,3x,Z4,3x,I10)') j,j,j
write(*,fmt='(B16,3x,Z4,3x,I10)') i,i,i
end
