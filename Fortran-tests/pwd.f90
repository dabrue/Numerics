program pid
implicit none

! this program tests to get the current working directory

character(len=80) :: pwd


call getcwd(pwd)

print*,pwd

end
