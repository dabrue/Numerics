      subroutine ErrWrt ( ErrMsg )
c
c-------------------------------- ErrWrt -------------------------------------
c
c >>> ErrWrt	-- writes a message to the standard error output file
c
c *** Calling Sequence:   call ErrWrt ( ErrMsg )
c
c === Latest Revision:    25 May 1988	(typed in)
c
c --- on entry the calling routine supplies --
c
c     ErrMsg	-- character string to be written to standard error
c
c --- on exit the routine returns --
c
c     nothing
c
c----------------------------- local declarations -----------------------------
c
c
      character*(*)	ErrMsg
c
c * * * * *                !	integer globals
      character*8	IGlobal		
c * * * * *              !	output line
      character*80	Line		
c * * * * *               !	output format
      character*8	MyForm		
c
c * * * * *            !	standard error unit number
      integer		StdErr		
c * * * * *            !	right index function
      integer		IndexR		
c * * * * *           !	# characters to output
      integer		NCOut		
c
c---------------------------- execution begins here ---------------------------
c
      if ( IGlobal('get','StdErr',StdErr) .ne. 'OK' ) RETURN
c
      Line	= ErrMsg
      NCOut	= max(1,IndexR(Line))
c
      MyForm	= '(a!!)'
      write ( MyForm(3:4), '(i2)' ) NCOut
c
      write ( StdErr, MyForm ) Line(1:NCOut)
c
      return
      end
