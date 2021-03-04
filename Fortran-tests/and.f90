program testand

logical :: a, b, c

a=.true.
b=.false.

if (xor(a,b)) then
    print*,"Yes"
else
    print*,"No"
endif 
end
