program how_many_open_files

integer :: i, j, k
integer :: ostat
character(len=30) :: filename

i=10
do 
    i=i+1
    write(filename,'(I30)'), i
    open(unit=i,file=filename,iostat=ostat)
    if (ostat /= 0) then
        print*,i-1
        exit
    endif
enddo

end


