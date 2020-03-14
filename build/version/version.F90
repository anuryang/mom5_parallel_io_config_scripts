
module version_mod

! <OVERVIEW>
!   This module provides a string which is the git hash (version) of the code
!   used to build this executable.
!
!   The hash can be read with the following command:
!   $ strings <executable> | grep MOM_COMMIT_HASH
! </OVERVIEW>

implicit none
private

character (len=*), parameter, public :: MOM_COMMIT_HASH = "MOM_COMMIT_HASH=75e267c03b68b1c862eb28831808e6fdc932ff20"

contains

subroutine dummy_sub()
end subroutine dummy_sub

end module version_mod
