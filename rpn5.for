      program translator
!
!     Translating algebraic expressions to polish notation
!
!     The variable names and their meanings are as follows:
!         input    The input string, in normal algebraic form
!         inputHier     Array containing the hierarchy numbers of the input
!         operatorStack    'operator stack': The operators from the input
!         operatorHier     Array containing the hierarchy numbers of the operators
!         polish    The ouput string, in polsih notation
!
!         l         Do index used in initializing
!         m         Do index used in setting up inputHier array
!         i      Pointer to index string (input and inputHier)
!         j      Pointer to operator stack (operatorStack and operatorHier)
!         k      Pointer to output string (polish)
!
!         The other variables are actually constants, and are
!         defined in the data statement.
!
!https://gcc.gnu.org/onlinedocs/gcc-3.4.6/g77/CYCLE-and-EXIT.html
!
      integer, dimension(40) :: inputHier, operatorHier
      character, dimension(40) :: operatorStack, polish, input
      character :: blank, lparen, rparen, plus, minus, astrsk, slash
      integer :: n,len,index,i,j,k

      blank = ' '
      lparen = '('
      rparen = ')'
      plus = '+'
      minus = '-'
      astrsk = '*'
      slash = '/'
      n = 40
      index = 0
      len = 0
      i = 0
      j = 0
      k = 0
!
!     Initialize arrays to zero or blank, as appropiate

  10  do i = 1, n
        inputHier = 0.
        operatorHier = 0.
        operatorStack = blank
        polish = blank
  20  end do

  !
  !   read a 'data' card
      
      write(*,*) 'Please enter input to be translated to RPN: '
      read(*, 30) input
  30  format(40A)

!     write(*,*) 'Output: ', input(1)

!     Get the length of the array entered
      do index = 1, n, 1
        if(input(index) == blank)then
!           write(*,*)'Found at ', index, len
            exit
            end if
        len = len + 1
      end do
      
!
!     In the following do-loop, m points to input columns, from left to right
!     First blank signals end of string (Embedded blanks are not allowed)
!     It is assumed that if a character is not an operator or a
!     parenthesis, it is a variable.

 !     do m = 1, 40
  !      if(input(m) == blank)  go to 60
  !    end do

!
!     ( 1
!     ) 2
!     + - 3
!     * / 4
!     In absence of () * / before + -
!     
!     Set inputHier(m) to xero, then change it if the character is an operator

      inputHier(m) = 0
      
      do m = 1, len, 1
        if(input(m) == lparen) inputHier(m) = 1
        if(input(m) == rparen) inputHier(m) = 2
        if(input(m) == plus .or. input(m) == minus) inputHier(m) = 3
        if(input(m) == astrsk .or. input(m) == slash) inputHier(m) = 4
      end do

      do index = 1, len, 1
        write(*,*) 'Hierachy of Input ', inputHier(index)
      end do
!
!     If input-string pointer = 1 on exit from do, input was blank

! 60  write(*,*) 'Input was a blank. The program will now end'
!  60   if(m == 1) stop

      i = 1
      k = 1
      j = 2
      operatorHier = -1

      do i = 1, len
        if(inputHier(i) == 0)then
          polish(k) = input(i)
          k = k + 1

        else if(inputHier(i) == 2)then
          j = j - 1

        else
          operatorStack(j) = input(i)
          j = j + 1
        end if
      end do

      do while (operatorHier(j-1) >= inputHier(i))
        polish(k) = operatorStack(j-1)
        j = j - 1
        k = k + 1
      end do

      if()

      write(*,*)'Polish ', polish
      end program translator