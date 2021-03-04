program complexkind

integer, parameter :: dp_kind = selected_real_kind(14,300)

complex(kind=dp_kind) :: A

A=(1,2)
print*,A

end program
