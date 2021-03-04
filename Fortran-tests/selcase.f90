program selcase
implicit none

integer :: i, j, k

i=1

select case (i)
    case(1)
        print*,"case 1"
    case(2)
        print*,"case 2"
    case default
        print*,"default"
end select 

end
