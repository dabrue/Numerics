program autoarrays

integer :: i, j, k, l
integer :: deck(6)

do i=1,6
    deck(i)=i
enddo

print*,deck

deck=(/ deck(7:),deck(:0),deck(1:6) /)
print*,deck

end
