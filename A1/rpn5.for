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
!         i      Integer used as array index (input and inputHier)
!         j      Integer used as array index (operatorStack and operatorHier)
!         k      Integer used as array index to output translation (polish)
!         len    The length of the string the user inputs
!         index  Used for finding the length of the input and finding operators

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
      index = 0
      i = 0
      j = 0
      k = 0

!     Main loop for the whole program
      do

!     Initialize arrays to zero or blank, as appropiate        
        inputHier = 0.
        operatorHier = 0.
        operatorStack = blank
        polish = blank
        len = 0

!     Prompt the user to enter the input that should be translated    
        write(*,*) 'Please enter input to be translated to RPN: '
        read(*, 30) input
  30    format(40A)

!     If they did not enter anything or just spaces then exit the program
        if(input(1) == blank) then
          exit
        end if

!     Get the length of the array entered
        do index = 1, 40, 1
          if(input(index) == blank .and. index > 1)then
              exit
              end if
          len = len + 1
        end do

!
!     ( 1
!     ) 2
!     + - 3
!     * / 4
!     In absence of () * / before + -
!     
!     If there is an operator, put the hierarchy value into inputHier

        do index = 1, len, 1
          if(input(index) == lparen) then
            inputHier(index) = 1
          else if(input(index) == rparen) then
            inputHier(index) = 2
          else if(input(index) == plus .or. input(m) == minus) then
            inputHier(index) = 3
          else if(input(index) == astrsk .or. input(m) == slash) then 
            inputHier(index) = 4
          end if
        end do

!       Initialize the array indicies and make operatorHier(1) -1
!          so it is not >= inputHier at the first loop
        k = 1
        j = 2
        operatorHier(1) = -1

        do i = 1, len
!     If it is an operator, put it into the final polish translation array
          if(inputHier(i) == 0)then
            polish(k) = input(i)
            k = k + 1

!     If it is a right parenthesis, then decrement the index for the operators
          else if(inputHier(i) == 2)then
            j = j - 1

!     If it is a +,-,*,/ then put it into the operatorStack and the hierarcy in
!       operatorHier
          else
            operatorStack(j) = input(i)
            operatorHier(j) = inputHier(i)
            j = j + 1
            cycle
          end if

!     remove the operators and put it with the polish output
          do while (operatorHier(j-1) >= inputHier(i + 1))
            polish(k) = operatorStack(j-1)
            j = j - 1
            k = k + 1
          end do
        end do

      write(*,*)'Original Input:  ', input
      write(*,*)'RPN Translation: ', polish

      end do
      end program translator