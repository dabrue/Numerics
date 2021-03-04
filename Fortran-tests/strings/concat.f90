program concat
implicit none

integer :: i, j, k, l

character(len=10) :: a
character(len=12) :: b
character(len=40) :: c

a="1"
b="2"

c=a//b

print*,c

c=""
print*,"len a is ", len(a)
print*,"len b is ", len(b)
k=len(a)
do i=len(a),1,-1
    if (a(i:i) == " ") then
        k=k-1
    else
        exit
    endif
enddo
l=len(b)
do i=len(b),1,-1
    if (b(i:i) == " ") then
        l=l-1
    else
        exit
    endif
enddo
c=a(1:k)//b(1:l)
print*,c


end program


