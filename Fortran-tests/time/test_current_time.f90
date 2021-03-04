program test_current_time
implicit none

character(len=25) :: now

call current_time(now)
print*,'now=',now
end
