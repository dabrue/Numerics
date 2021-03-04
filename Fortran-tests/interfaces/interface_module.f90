module interface_module

INTERFACE
    subroutine sub1(x, y, z)
        implicit none
        real, intent(in) :: x, y
        real, intent(out) :: z
    end subroutine sub1

    subroutine sub2(i, j, k)
        implicit none
        integer, intent(in) :: i, j
        integer, intent(out) :: k
    end subroutine sub2
END INTERFACE

end module interface_module
    
