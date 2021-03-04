program inq
implicit none


integer, parameter :: name_unit = 30


logical :: there

inquire(unit=name_unit, exist=there)
if (there) then
print*,'namelist there'
open (unit=name_unit, file='namelistout', status='old')
else
print*,"notthere"
endif

end
