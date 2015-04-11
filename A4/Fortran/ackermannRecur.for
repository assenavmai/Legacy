	! Ackermann function, implemeneted recursively
	! Timings included
	! Vanessa White, 2015

	recursive function ackermann(m,n) result(r)
		integer, intent(in) :: m,n
		integer :: r

		if(m == 0) then
			r = n + 1
		else if(n == 0) then
			r = ackermann(m -1, 1)
		else
			r = ackermann(m - 1, ackermann(m, n - 1))
		end if
	end function ackermann

	program recursiveAckermann

		implicit none

		integer :: m, n, i, j, result, ackermann
		integer :: start, finish, rate
        real :: elapsed
		
		write(*,*) 'Enter m: '
		read(*, *) m
		write(*,*) 'Enter n: '
		read(*, *) n

		write(*,*)'M: ', m
		write(*,*)'N: ', n

		call system_clock(count_rate = rate)
        call system_clock(count = start)
		
		do i = 0, m
		    do j = 0, n - m
		        result = ackermann(m, n)
		    end do
		end do

		call system_clock(count = finish)

        elapsed = real(finish - start)/rate

		write(*,*) 'Result: ', result
        write(*,*) 'Elasped time in milliseconds: ',(1000*elapsed)
        
	end program recursiveAckermann