program characters
implicit none

character(len=20) :: text
integer :: leng


text="ABCDEF"

leng=len_trim(text)
print*,"leng=",leng
print*,"text ="//text//"A"
print*,trim(text)//"A"

end
