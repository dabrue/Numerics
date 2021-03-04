    module input_scalar_module
        !  Define generic interface 'force' to specific functions
        !  'real_force' and 'double_force'.
        interface read_scalar 
            ! Declare function and dummy argument types.
            real*8 function read_double(DUNIT,variable,comment)
                integer DUNIT
                character*(*) variable
                character*(*) comment
            end function read_double
            integer function read_int(IUNIT,ivariable,icomment)
                integer IUNIT
                character*(*) ivariable
                character*(*) icomment
            end function read_int
            logical function read_logical(LUNIT,variable,comment)
                integer LUNIT
                character*(*) variable
                character*(*) comment
            end function read_logical
        end interface
    end module

