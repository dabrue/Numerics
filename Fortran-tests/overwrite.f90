
      PROGRAM CRCTRL
!     ------------------------------------------------------------------
      WRITE(*,*)
      WRITE(*,*)     ' LIST DIRECTED I/O '
      WRITE(*,*)     ' ================= '
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line:  "+abcd"  (Overwrite Mode): '
      WRITE(*,*)     '+abcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      WRITE(*,*)     ' FORMATTED I/O '
      WRITE(*,*)     ' ============= '
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line = "xabcd"  (A non-control char): '
      WRITE(*,'(A)') 'xabcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line = " abcd"  (Normal Mode): '
      WRITE(*,'(A)') ' abcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line = "+abcd"  (Overwrite Mode): '
      WRITE(*,'(A)') '+abcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line = "0abcd"  (Double-spacing): '
      WRITE(*,'(A)') '0abcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      WRITE(*,*)     ' Writing line = "1abcd"  (New-page): '
      WRITE(*,'(A)') '1abcd'
      WRITE(*,*)
!     ------------------------------------------------------------------
      END
