      function IndexR ( String )
c
c----------------------------------------------------------------------------
c
c >>> IndexR -- returns the index of the last non-blank character, or a zero
c >>>             if the entire string is blank
c
c *** Calling Sequence:         IPos    = IndexR ( String )
c
c----------------------------------------------------------------------------
c
c
      integer           IndexR
      character*(*)     String
c
c * * * * *                             !       loop index
      integer           i
c
c----------------------- execution begins here ---------------------------
c
      do 1 i = len(String),1,-1
        IF ( String(i:i) .ne. ' ' ) THEN
	  IndexR = i
	  RETURN
	END IF
    1 continue
c
      IndexR = 0
c
      return
      end
