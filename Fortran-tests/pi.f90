program pi
implicit none
integer, parameter :: dp=selected_real_kind(26,300)
real (kind=dp) :: pies

pies = 4.d0* atan2(1.d0,1.d0)

print '(2F35.33)', pies,4.d0
end program pi

