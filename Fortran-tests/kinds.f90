program kinds
implicit none

! this program tests different accuracies and prints kind numbers

integer :: i, j, k, l
integer :: k1, k2, k3, k4, k5, k7, k8


k1=selected_real_kind(1,1)
k2=selected_real_kind(8,10)
k3=selected_real_kind(9,10)
k4=selected_real_kind(10,10)
k5=selected_real_kind(23,1000)


print*,k1
print*,k2
print*,k3
print*,k4
print*,k5


end
