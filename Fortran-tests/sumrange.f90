program sumrange
implicit none

integer :: i, j, k, sume, sumd


do i=0,30
        sume=0
        do k=0,i
                sume=sume+k
        enddo
        if (modulo(i,2)==0) sumd=(i/2)*(i+1)
        if (modulo(i,2)==1) sumd=((i+1)/2)*i
        print*, i, sume, sumd
enddo

end
