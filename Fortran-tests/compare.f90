program compare
implicit none

logical :: a, b

a=.true.
b=.false.

print*,"A and B"
if ( a .or. b ) then 
print*,'yep'
endif 
end
