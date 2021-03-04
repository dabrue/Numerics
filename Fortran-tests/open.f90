program openfile
implicit none


integer :: stat
stat=0
! TRY OPENING A FILE
open(unit=12,file="oldfile",status="new",iostat=stat)
print*,"iostatius is",stat

end
