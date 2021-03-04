program kindstest
implicit none

integer :: i, k, kl


kl=-1.d0
do i=1,10000
    k=selected_int_kind(i)
    if (k /= kl) then
        print*, i, k
        kl=k
    endif
enddo

end 
    
    
