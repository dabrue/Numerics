      function IGlobal ( Command, Name, Value )
c
c------------------------------------------------------------------------------
c
c >>> IGlobal   -- integer global variable saver routine
c
c *** Calling Sequence:         Result  = IGlobal(Command,Name,Value)
c
c --- on entry the calling routine supplies --
c
c     Command   -- character string indicating whether the indicated global
c                       variable is to be saved, retrieved, or deleted
c                       Possible Commands are:
c                               Command = 'save'        to save a global
c                               Command = 'get'         to retrieve one
c                               Command = 'delete'      to remove one
c                               Command = 'list'        to write EVERYTHING
c               NOTE:  only the first character of Command is significant
c
c     Name      -- character string (8 or fewer characters) indicating the
c                       unique name of the global to be saved/retrieved/etc.
c
c     Value     -- integer which is an input variable if Command='save'
c                       If Command .ne. 'save', Value is not read on input.
c
c --- on exit the routine returns --
c
c     Value     -- is an output integer variable only if Command='get', in
c                       which case the remembered value of the Name-d
c                       global variable is returned.
c
c     IGlobal   -- is a character string indicating the success/failure of
c                       the operation.  Possible returns are:
c                               IGlobal = 'OK'    if all was OK
c                               IGlobal = 'CANT'  if no internal space left on
c                                               a 'save' operation, or if the
c                                               Named variable is not here on
c                                               a 'delete' or 'get'.
c                               IGlobal = 'WHAT'  if Command unrecognized
c
c------------------------------------------------------------------------------
c
c
      character*(*)     IGlobal
      character*(*)     Command
      character*(*)     Name
      integer           Value
c
      integer           MAXSave
      parameter         (MAXSave=100)
c
      integer           NSaved
c * * * * *                             !       loop index
      integer           i
c * * * * *                             !       new value of NSaved
      integer           new
c * * * * *                             !       value of output unit if 'list'
      integer           iout
c
      integer           Save(MAXSave)
      character*8       VNames(MAXSave)
c
      save
c
      data      NSaved  / 5 /
c
      data      VNames(1)       / 'StdIn'       /
      data      Save(1)         /     9         /
c
      data      VNames(2)       / 'StdOut'      /
      data      Save(2)         /     9         /
c
      data      VNames(3)       / 'StdErr'      /
      data      Save(3)         /     9         /
c
      data      VNames(4)       / 'StdDbg'      /
      data      Save(4)         /     9         /
c
      data      VNames(5)       / 'StdWrt'      /
      data      Save(5)         /     9         /
c
c
c---------------------------- execution begins here ---------------------------
c
c
c                        --- blank Names NOT allowed ---
c
      IF ( Name .eq. ' ' ) THEN
        IGlobal = 'CANT'
        RETURN
      END IF
c
c                    --- special case if Command = 'list' ---
c
      IF ( Command(1:1) .eq. 'l' ) THEN
        do 100 i = 1, NSaved
          IF ( Name .eq. VNames(i) ) THEN
            iout        = Save(i)
            go to 101
          END IF
  100   continue
        iout    = 0
        IGlobal = 'CANT'
  101   continue
        if ( iout .eq. 0 ) RETURN
c
        write ( iout, * ) '   === Integer Globals ==='
        do 200 i = 1, NSaved
          IF ( VNames(i) .ne. ' ' ) THEN
            write ( iout, '(5x,a8,'' = '',i10)' ) VNames(i), Save(i)
          END IF
  200   continue
        IGlobal = 'OK'
        RETURN
      END IF
c
c                     --- has Name already been defined? ---
c
      do 1 i = 1, NSaved
        if ( Name .eq. VNames(i) ) go to 2
    1 continue
      i = 0
    2 continue
c
c---------------------------- saving a value ----------------------------------
c
      IF      ( Command(1:1) .eq. 's' ) THEN
c
        IF ( i .eq. 0 ) THEN
          new   = NSaved + 1
          IF ( new .gt. MAXSave ) THEN
c
c               --- arrays full, look for a blank entry ---
c
            do 10 i = 1, NSaved
              if ( VNames(i) .eq. ' ' ) go to 11
   10       continue
            i = 0
   11       continue
            IF ( i .eq. 0 ) THEN
              IGlobal   = 'CANT'
              RETURN
            ELSE
              new       = NSaved
            END IF
          END IF
c
c                --- save value for the newly defined global ---
c
          NSaved         = new
          VNames(NSaved) = Name
          Save(NSaved)   = Value
          IGlobal        = 'OK'
c
c           --- save a new value for a previously defined global ---
c
        ELSE
          Save(i)          = Value
          IGlobal          = 'OK'
        END IF
c
c----------------------------- retrieving a value -----------------------------
c
      ELSE IF ( Command(1:1) .eq. 'g' ) THEN
c
        IF ( i .eq. 0 ) THEN
          IGlobal       = 'CANT'
        ELSE
          IGlobal       = 'OK'
          Value         = Save(i)
        END IF
c
c----------------------------- deleting a global -------------------------------
c
      ELSE IF ( Command(1:1) .eq. 'd' ) THEN
c
        IF ( i .eq. 0 ) THEN
          IGlobal       = 'CANT'
        ELSE
          IGlobal       = 'OK'
          VNames(i)     = ' '
        END IF
c
c---------------------------- unrecognized command ----------------------------
c
      ELSE
        IGlobal = 'WHAT'
      END IF
c
      return
      end
