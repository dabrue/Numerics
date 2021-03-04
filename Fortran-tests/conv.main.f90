!Hyperspherical to Cartesian Coordinates

PROGRAM CONVERSION
IMPLICIT NONE
integer::  repeating
character :: option

Do repeating=1,1000
!Failsafe against infinite loop. After a thousand calculations, 
!even hyperspherical coordinates could get boring. 
print*,' '
print*,'Enter number for the operation you want.'
print*,'1.) Cartesian to Hyperspherical'
print*,'2.) Hyperspherical to Cartesian'
print*,'3.) Exit'
read*,option
select case (option)
   case ('1')
      call HYPER
   case ('2')
      call CARTE
   case ('3')
      STOP
   case ('x')
      STOP
   case default
      print*,'Unrecognized response'
end select
end do

end program CONVERSION

subroutine HYPER ! program for changing cartesian to hyperspherical
implicit none
double precision :: x1, y1, z1, x2, y2, z2, x3, y3, z3, m1, m2, m3, cmx, cmy, cmz, chi, theta, alpha, beta, gama 
double precision :: xcm1,xcm2,xcm3,ycm1,ycm2,ycm3,zcm1,zcm2,zcm3
double precision :: yaxx, yaxy, yaxz, rho,a,b,c
double precision, dimension(3,3) :: I, J, K, Itrans
double precision, dimension(3) :: X, Y, Z
double precision ::PI
integer :: p, q
I=0.d0
K=0.d0
X=0.d0
Y=0.d0
Z=0.d0
PI=4.d0*atan(1.d0)
print*,'Program for changing cartesian to hyperspherical coordinates'
print*,' '
print*,'Assuming for now that the particles have equal mass'
print*,'Enter cartesian coordinates for three particles'
print*,'x1'
read*,x1
print*,'y1'
read*,y1
print*,'z1'
read*,z1
print*,'x2'
read*,x2
print*,'y2'
read*,y2
print*,'z2'
read*,z2
print*,'x3'
read*,x3
print*,'y3'
read*,y3
print*,'z3'
read*,z3
m1=1.
m2=1.
m3=1.

call COM(x1,y1,z1,x2,y2,z2,x3,y3,z3,m1,m2,m3,cmx,cmy,cmz) !finds center of mass location
call YAXIS(x1,y1,z1,x2,y2,z2,x3,y3,z3,yaxx,yaxy,yaxz,alpha,beta)

!Change to body frame reference

xcm1=x1-cmx
xcm2=x2-cmx
xcm3=x3-cmx
ycm1=y1-cmy
ycm2=y2-cmy
ycm3=y3-cmy
zcm1=z1-cmz 
zcm2=z2-cmz
zcm3=z3-cmz


I(1,1)=m1*(ycm1*ycm1+zcm1*zcm1)+m2*(ycm2*ycm2+zcm2*zcm2)+m3*(ycm3*ycm3+zcm3*zcm3) ! Ixx component
I(1,2)=-m1*(xcm1*ycm1)-m2*(xcm2*ycm2)-m3*(xcm3*ycm3)                              ! Ixy component
I(1,3)=-m1*(xcm1*zcm1)-m2*(xcm2*zcm2)-m3*(xcm3*zcm3)                              ! Ixz component
I(2,1)=-m1*(ycm1*xcm1)-m2*(ycm2*xcm2)-m3*(ycm3*xcm3)                              ! Iyx component
I(2,2)=m1*(xcm1*xcm1+zcm1*zcm1)+m2*(xcm2*xcm2+zcm2*zcm2)+m3*(xcm3*xcm3+zcm3*zcm3) ! Iyy component
I(2,3)=-m1*(ycm1*zcm1)-m2*(ycm2*zcm2)-m3*(ycm3*zcm3)                              ! Iyz component
I(3,1)=-m1*(xcm1*zcm1)-m2*(xcm2*zcm2)-m3*(xcm3*zcm3)                              ! Izx component
I(3,2)=-m1*(ycm1*zcm1)-m2*(ycm2*zcm2)-m3*(ycm3*zcm3)                              ! Izy component
I(3,3)=m1*(xcm1*xcm1+ycm1*ycm1)+m2*(xcm2*xcm2+ycm2*ycm2)+m3*(xcm3*xcm3+ycm3*ycm3) ! Izz component

call DIAGONALIZE(I,J,K)

!print*,'original intertial tensor matrix I (after dsyevd)'
!
!do p=1,3
!print*,I(p,1),I(p,2),I(p,3)
!enddo
!
!print*,' K matrix, should NOT be identicle to above,but identical to two above that'
!do p=1,3
!print*,K(p,1),K(p,2),K(p,3)
!enddo

!call CHKEIGEN(J,I)
call Yaxiseigenvector(yaxx,yaxy,yaxz,I,Y)
call EulerAngles(I,J,K,Y,X,Z,a,b,c)

end subroutine HYPER

subroutine CARTE ! program for changing hyperspherical to cartesian
implicit none
print*,'Program cartesian'
end subroutine CARTE

!COM finds the location of the center of mass 
subroutine COM(x1,y1,z1,x2,y2,z2,x3,y3,z3,m1,m2,m3,cmx,cmy,cmz)
implicit none
double precision :: x1,y1,z1,x2,y2,z2,x3,y3,z3,m1,m2,m3,cmx,cmy,cmz
cmx=(m1*x1+m2*x2+m3*x3)/(m1+m2+m3)
cmy=(m1*y1+m2*y2+m3*y3)/(m1+m2+m3)
cmz=(m1*z1+m2*z2+m3*z3)/(m1+m2+m3)
end subroutine COM




subroutine YAXIS(x1,y1,z1,x2,y2,z2,x3,y3,z3,yaxx,yaxy,yaxz,alpha,beta)
implicit none
double precision :: r1x, r1y, r1z, r2x, r2y, r2z, s, x1,y1,z1,x2,y2,z2,x3,y3,z3,yaxx,yaxy,yaxz,alpha,beta
double precision :: PI
PI=4.d0*atan(1.d0)
!define two vectors from differeneces of positions and cross them to find the axis
!normal to the plane defined by the particles.  left unnormalized. 
r1x=x2-x1 ! define vector one
r1y=y2-y1
r1z=z2-z1
r2x=x3-x1 ! define vector two
r2y=y3-y1
r2z=z3-z1
yaxx=r1y*r2z-r2y*r1z !cross vectors one and two. 
yaxy=r2x*r1z-r1x*r2z
yaxz=r1x*r2y-r2x*r1y 


! beta is the polar angle, alpha is the azimuthal
! define beta from old y axis, define alpha from old z axis

s=Sqrt(yaxx*yaxx+yaxz*yaxz)
beta=atan2(s,yaxy)
alpha=atan2(yaxx,yaxz)
end subroutine YAXIS


subroutine DIAGONALIZE(I,J,K)
implicit none
double precision, dimension(3,3) :: I,J,K,Ident
double precision, dimension(3) :: L
double precision :: N(1000), M(1000)
double precision :: info, thresh
integer :: p,q
thresh=1.0E-13
Ident=0.0
Ident(1,1)=1.d0         ! define identity matrix
Ident(2,2)=1.d0
Ident(3,3)=1.d0
K=I

!print*,'original intertial tensor matrix I (before dsyevd)'
!
!do p=1,3
!print*,I(p,1),I(p,2),I(p,3)
!enddo
!
!print*,' K matrix, should be identicle to above'
!do p=1,3
!print*,K(p,1),K(p,2),K(p,3)
!enddo



!ARGUMENTS OF SSYEVD MKL FUNCTION
!?syevd(job, uplo, n, a, lda, w, work, lwork, iwork, liwork, info)
! job=> 'N' or 'V' only. if N, only eigenvalues are computed, if V, eigenvectors computed, too
! uplo=> 'U' or 'L', stores only upper or lower part of triangular matrix. For symmetric, doesn't matter which you use. 
! n is the order of the matrix a, ie, how many rows
! a is the input matrix
! lda is the dimension of the matrix a, ie. how long the row is. 
! w is the output matrix
! work is a workspace array. must be real for ssyevd, double precision for dsyevd
! lwork, integer, dimension of array work. If job=N, lwork>=2*n+1, if job=V, then lwork>=3*n*n+(5+2k)*n+1 where
!     	k is the smallest integer which satisfies 2^k>=n
! iwork, workspace array, dimension at least liwork
! liwork, integer, dimension of array iwork. if n<=1, liwork>=1. if job=N and n>1, liwork>=1. if job=V and n>1, liwork >=5n+2
! info reports the success of ?syevd
call dsyevd('V','U',3,I,3,J,M,1000,N,1000,info)

! J contains list of eigenvalues, but all in first column, and this is odd, so I'm moving them to the diagonal elements
J(2,2)=J(2,1)
J(3,3)=J(3,1)
J(3,1)=0.0
J(2,1)=0.0

! for procaution, set K=I prior to dsyevd because I changed from what it was before, don't want to get mixed up. 



end subroutine DIAGONALIZE

subroutine CHKEIGEN(J,K)
implicit none
double precision, dimension(3,3) :: L,J,K,Ktrans,Ident
integer :: p,q
Ident=0.d0
do p=1,3   
   Ident(p,p)=1.d0    !initialize the identity matrix
   do q=1,3
      Ktrans(p,q)=K(q,p) ! initalize the transpose matrix 
   enddo
enddo

!L=matmul(Ktrans,K)
!do p=1,3
!      print*,L(p,1), L(p,2), L(p,3)
!enddo

print*,' '
print*,'The Diagonalized Intertial Tensor'
do p=1,3
      print*,J(p,1), J(p,2),J(p,3)
enddo
print*,' '

end subroutine CHKEIGEN

subroutine Yaxiseigenvector(yaxx,yaxy,yaxz,I)
implicit none
double precision ::  yaxx, yaxy, yaxz, I(3,3), dot(3), Y(3), mag
integer :: p,q
!ensure normalized?
mag=Sqrt(yaxx*yaxx+yaxy*yaxy+yaxz*yaxz)
Y(1)=yaxx/mag
Y(2)=yaxy/mag
Y(3)=yaxz/mag
dot(1)=Y(1)*I(1,1)+Y(2)*I(2,1)+Y(3)*I(3,1)
dot(2)=Y(1)*I(1,2)+Y(2)*I(2,2)+Y(3)*I(3,2)
dot(3)=Y(1)*I(1,3)+Y(2)*I(2,3)+Y(3)*I(3,3)
print*,'Dot products of Y axis unit vector with eigen vectors of inertial tensor'
print*,dot(1),dot(2),dot(3)




end subroutine Yaxiseigenvector

subroutine EulerAngles(I,J,K,Y,X,Z,a,b,c)
implicit none
double precision :: a,b,c,I(3,3),J(3,3),K(3,3),Y(3),X(3),Z(3),R(3,3),cross(3),PI
double precision :: Itrans(3,3),temp(3,3),Id(3,3)
double precision :: testx, testy, testz(2), norm(3)
integer :: p,q
PI=4.d0*atan(1.d0)
!determining which axis goes where from the eigenvectors of the inerital tensor
!Ixx + Izz = Iyy, so aligning Y axis along greatest inertial moment
! and aligning Z axis along least inertial moment

do p=1,3
do q=1,3
Itrans(p,q)=I(q,p)
enddo
enddo


!print*,'comparisons on transformation matrix multiplication'
!
print*,'K matrix: the original intertial tensor, trying to diagonalize'
do p=1,3
print*, K(p,1),K(p,2),K(p,3)
enddo

print*,'eigenvalues'
print*, J(1,1),J(2,2),J(3,3)
print*,' '
temp=matmul(Itrans,K)
Id=matmul(temp,I)

print*,'I matrix, contains eigenvectors corresponding to eigen values of J matrix'
do p=1,3
print*, I(p,1),I(p,2),I(p,3)
enddo
print*,' '

print*, 'Id matrix, K diagonalized, result of matmul(temp,I)'
do p=1,3
print*, Id(p,1),Id(p,2),Id(p,3)
enddo


if (J(3,3).GT.J(2,2).and.J(3,3).GT.J(1,1)) then
     do p=1,3
        Y(p)=I(p,3)
     enddo
     if (J(2,2).GT.J(1,1)) then
          do p=1,3
             Z(p)=I(p,1)
             X(p)=I(p,2)
          enddo
     else
          do p=1,3
             Z(p)=I(p,2)
             X(p)=I(p,1)
          enddo
     endif 
endif

if (J(2,2).GT.J(1,1).and.J(2,2).GT.J(3,3)) then
     do p=1,3
        Y(p)=I(p,2)
     enddo
     if (J(3,3).GT.J(1,1)) then
          do p=1,3
             Z(p)=I(p,1)
             X(p)=I(p,3)
          enddo
     else
          do p=1,3
             Z(p)=I(p,3)
             X(p)=I(p,1)
          enddo
     endif
endif

if (J(1,1).GT.J(2,2).and.J(1,1).GT.J(3,3)) then
     do p=1,3
        Y(p)=I(p,1)
     enddo
     if (J(2,2).GT.J(3,3)) then
          do p=1,3
             Z(p)=I(p,3)
             X(p)=I(p,2)
          enddo
     else
          do p=1,3
             Z(p)=I(p,2)
             X(p)=I(p,3)
          enddo
     endif
endif
b=acos(Z(3))
a=atan2(Y(3),X(3))
c=atan2(Z(2),(-Z(1)))

if (a.LT.0.d0) a=a+2*Pi
if (b.LT.0.d0) b=b+2*Pi
if (c.LT.0.d0) c=c+2*Pi

print*,'angles alpha, beta, and gamma'
print*,a,b,c
print*,' '

print*,'Rotation Matrix'
R(1,1)=cos(a)*cos(b)*cos(c)-sin(a)*sin(c)
R(2,1)=-cos(a)*cos(b)*sin(c)-sin(a)*cos(c)
R(3,1)=cos(a)*sin(b)
R(1,2)=sin(a)*cos(b)*cos(c)+cos(a)*sin(c)
R(2,2)=-sin(a)*cos(b)*sin(c)+cos(a)*cos(c)
R(3,2)=sin(a)*sin(b)
R(1,3)=-sin(b)*cos(c)
R(2,3)=sin(b)*sin(c)
R(3,3)=cos(b)

do p=1,3
print*,R(p,1), R(p,2),R(p,3)
enddo
print*,' '
do p=1,3
print*,X(p),Y(p),Z(p)
enddo

print*,' '
print*,' result of X(3)xY(3)'
cross(1)=X(2)*Y(3)-Y(2)*X(3)
cross(2)=Y(1)*X(3)-X(1)*Y(3)
cross(3)=X(1)*Y(2)-Y(1)*X(2)

print*,Z(1),Z(2),Z(3)
print*,cross(1),cross(2),cross(3)

end subroutine EulerAngles
