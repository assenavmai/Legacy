      program translator
!
!     Translating algebraic expressions to polish notation
!
!     The variable names and their meanings are as follows:
!         input    The input string, in normal algebraic form
!         inputHier     Array containing the hierarchy numbers of the input
!         inputOperators    'operator stack': The operators from the input
!         operatorHier     Array containing the hierarchy numbers of the operators
!         polish    The ouput string, in polsih notation
!
!         l         Do index used in initializing
!         m         Do index used in setting up inputHier arrau
!         i         Pointer to index string (input and inputHier)
!         j         Pointer to operator stack (inputOperators and operatorHier)
!         k         Pointer to output string (polish)
!
!         The other variables are actually constants, and are
!         defined in the data statement.
!
!
      integer, dimension(40) :: inputHier, operatorHier
      character, dimension(40) :: inputOperators, polish, input
      character :: blank, lparen, rparen, plus, minus, astrsk, slash
      integer :: i,n,k, ptrI, ptrJ, ptrK
!      integer, pointer :: ptrI, prtJ, ptrK

      blank = ' '
      lparen = '('
      rparen = ')'
      plus = '+'
      minus = '-'
      astrsk = '*'
      slash = '/'
      i = 0
      n = 40
      k = 0
!
!     Initialize arrays to zero or blank, as appropiate

  10  do i = 1, n
        inputHier = 0.
        operatorHier = 0.
        inputOperators = blank
        polish = blank
  20  end do     

!
!     read a 'data' card
      
      write(*,*) 'Please enter input to be translated to RPN: '
      read(*, 30) input
  30  format(40A)


!
!     In the following do-loop, m points to input columns, from left to right
!     First blank signals end of string (Embedded blanks are not allowed)
!     It is assumed that if a character is not an operator or a
!     parenthesis, it is a variable.

      do m = 1, 40
        if(input(m) == blank)  go to 60
      end do


!
!     Set inputHier(m) to xero, then change it if the character is an operator
      inputHier(m) = 0

      if(input(m) == lparen) inputHier(m) = 1

      if(input(m) == rparen) inputHier(m) = 2

      if(input(m) == plus .or. input(m) == minus) inputHier(m) = 3

      if(input(m) == astrsk .or. input(m) == slash) inputHier(m) = 4
  40  continue

!
!     If normal exit is taken, the card did not contain a blank
      
      write(*,50)
  50  format(1X, 'Data input error. No blanks allowed')
      go to 10


!
!     If input-string pointer = 1 on exit from do, input was blank

!  60  write(*,*) 'Input was a blank. The program will now end'
  60   if(m == 1) stop

!
!     Otherwise proceed to translation
!     Initialize hierarchy numbers to get started properly

      inputHier(m) = 0
      operatorHier(1) = -1
!
!     Initialize pointers

      ptrI = 1
      ptrJ = 2
      ptrK = 1

!
!     Check for operand

  70  if(inputHier(ptrI) == 0) go to 90  

!     Check for right parenthesis

      if(inputHier(ptrI) == 2) go to 80

!
!     Some other operator if here -- move to operator stack

      inputOperators(ptrJ) = input(ptrI)
      operatorHier(ptrJ) = inputHier(ptrI)

!
!     Advance pointers
      ptrI = ptrI + 1
      ptrJ = ptrJ + 1
      go to 70

!
!     Delete corresponding left parenthesis
   
   80 ptrI = ptrI + 1
      ptrJ = ptrJ - 1
      go to 100
!
!     Move operand to polish string
      
  90  polish(ptrK) = input(ptrI)
      ptrI = ptrI + 1
      ptrK = ptrK + 1

!
!     Check hierarchy rankings

  100 if(operatorHier(ptrJ - 1) >= inputHier(ptrI)) goto 110

!
!     Check for end of input string
      if(ptrI == m) go to 120
      go to 70
!
!     Move operator to polish string

  110 polish(ptrK) = inputOperators(ptrJ-1)
      ptrK = ptrK + 1
      ptrJ = ptrJ - 1
      go to 100
!
!     Write input and polish strings

  120 write(*,130) 'Input: ',input, 'RPN:',polish
  130 format(1H ,A7, 40A1/1H , A7, 40A1)
      go to 10
      end
