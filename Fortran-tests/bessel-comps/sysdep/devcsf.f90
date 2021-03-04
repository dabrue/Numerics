      subroutine devcsf(na,hamil,nb,eig,vec,nc)
      implicit none
      integer na, nb, nc, info, lwork
      real*8 hamil(na,na), vec(na,na), eig(na)
      real*8 work(200,200)

      lwork=200*200
      vec=hamil
      call dsyev('V','U',na,vec,na,eig,work,lwork,info)

      return
      end
