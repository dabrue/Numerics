program matchng

integer  :: i, j, ij, ji



do j=1,5
  do i=1,j
     ij=i+(j-1)*5
     ji=j+(i-1)*5
     print*,"ij",ij,"ji",ji
  enddo
enddo
end
     
