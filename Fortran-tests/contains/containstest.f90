module contains_test_mod

contains

  subroutine add_module(a,b,c)
     integer :: a, b, c

     c=a+b
  end subroutine add_module

end module contains_test_mod
program containstest
use contains_test_mod
implicit none

integer :: a, b, c
a=2
b=3

call add_module(a,b,c)

print*,c


end program containstest

