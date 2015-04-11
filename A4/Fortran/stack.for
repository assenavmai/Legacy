       ! Stack module taken from: http://rosettacode.org/wiki/Stack#Fortran
       ! Iterative ackermann function using a stack
       ! Vanessa White, 2015

       module stack
        
              public
        
              ! Define the data-structure to hold the data
              type stack_var
                     integer, allocatable :: data(:)
                     integer              :: size = 0
              end type stack_var
        
              ! Set the size of allocated memory blocks
              integer, parameter, private :: block_size = 10
        
              contains
        
              ! Push ----------------------------------------------------------------------
              subroutine push(s, e)
                     type(stack_var), intent(inout) :: s
                     integer, intent(in)            :: e
                     integer, allocatable :: wk(:)

                     ! Allocate space if not yet done
                     if (.not. allocated(s%data)) then
                            allocate(s%data(block_size))
                     elseif (s%size == size(s%data)) then   !Grow the allocated space
                            allocate(wk(size(s%data)+block_size))
                            wk(1:s%size) = s%data
                            call move_alloc(wk,s%data)
                     end if
        
                     ! Store the data in the stack
                     s%size = s%size + 1
                     s%data(s%size) = e
               end subroutine push
        
              ! Pop -----------------------------------------------------------------------
              function pop(s)
                     integer :: pop
                     type(stack_var), intent(inout) :: s
                     
                     if (s%size == 0 .or. .not. allocated(s%data)) then
                            pop = 0
                            return
                     end if
                     
                     pop = s%data(s%size)
                     s%size = s%size - 1
              end function pop
        
              ! Peek ----------------------------------------------------------------------
              integer function peek(s)
                     type(stack_var), intent(inout) :: s
                     
                     if (s%size == 0 .or. .not. allocated(s%data)) then
                            peek = 0
                            return
                     end if
                     
                     peek = s%data(s%size)
              end function peek
        
              ! Empty ---------------------------------------------------------------------
              logical function empty(s)
                     type(stack_var), intent(inout) :: s
                     empty = (s%size == 0 .or. .not. allocated(s%data))
              end function empty
        
       end module stack

       ! Iterative Ackermann function
       integer function ackermann(m,n)
              use stack
              implicit none
              type(stack_var) :: st
              integer, intent(in) :: m,n
              integer :: r, poppedVal, tempN

              call push(st, m)
              tempN = n
              do
                     if(empty(st)) exit

                     poppedVal = pop(st)

                     if(poppedVal == 0) then
                            tempN = tempN + 1
                     elseif(tempN == 0) then
                            tempN = 1
                            call push(st, poppedVal - 1)
                     else
                            tempN = tempN - 1
                            call push(st, poppedVal - 1)
                            call push(st, poppedVal)
                     end if
              end do

              ackermann = tempN

       end function ackermann
        
       program iterative

              implicit none

              integer :: m, n, i, j, result, ackermann
              integer :: start, finish, rate
              real :: elapsed

              write(*,*) 'Enter m: '
              read(*, *) m
              write(*,*) 'Enter n: '
              read(*, *) n

              call system_clock(count_rate = rate)
              call system_clock(count = start)

              result = ackermann(m,n)

              call system_clock(count = finish)

              elapsed = real(finish - start)/ rate
              
              write(*,*) 'Result: ', result
              write(*,*) 'Elasped time in milliseconds: ',(1000*elapsed)
         
       end program iterative