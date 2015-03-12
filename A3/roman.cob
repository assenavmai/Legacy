* Program to convert roman numerals to its equivalent decimal value.
* Migrated from legacy Cobol code.
* Author: Vanessa White
* Course: CIS*3190
* Date last edited: March 8th, 2015.

identification division.
program-id. getvalue.
environment division.
input-output section.
file-control.
	select standard-input assign to keyboard.
	select standard-output assign to display.
	select ifile assign to filename
		organization is line sequential.
data division.
file section.
fd standard-input.
	01 stdin-record    pic x(80).
fd standard-output.
	01 stdout-record   pic x(80).
fd ifile.
	01 input-record.
		05 numeral 	pic x(30).
		05 filename pic x(30).
working-storage section.
01 array-area.
	02 letter pic x occurs 30 times.
77	i pic S99 usage is computational.
77	val pic S9(4) usage is computational.
77	summation pic S9(8) usage is computational.
77 	prev pic S9(8) usage is computational.
77 	str pic x(30).
77	eof-switch pic 9 value 1.
77 	counter pic 999 value 0.
77	invalidFlag pic 9 value 0.


procedure division.

	open input standard-input, output standard-output.

*	Show an introduction to the program for the user
	display ""
	display "Welcome to the Roman Numeral Convertor."
	display "Enter a roman numeral statement and it will be converted to its equivalent decimal value"
	display "Enter 'f' at anytime to read a file and convert the roman numeral values"
	display "Enter 'q' at anytime to quit."
	display ""

* Continue to prompt the user to enter input until they type 'q'
	perform until letter(i) = 'q'

		move 0 to prev
		move 1 to i
		move 0 to summation

		display "Enter roman numerals, read a (f)ile or (q)uit: " with no advancing
		accept array-area

*		Close the program if they 
		if letter(1) = 'q' then
				display ""
				display "You chose to quit. Goodbye."
				stop run
		end-if 

*	If the user chooses to read from a file
		if letter(1) = 'f' then

*		Prompt the user for a filename
			display ""
			display "Please enter the filename: "
			accept filename 
			display "Filename: " filename
			open input ifile

*	Continue to read through the file and convert the roman numerals
			perform
				until eof-switch = 0
				read ifile into array-area
					at end move 0 to eof-switch
				end-read

				if eof-switch is not = 0
					move numeral to array-area
					perform getvalue
					display numeral
					display "Decimal Value: " summation
					display ""

					move 1 to i
					move 0 to prev
					move 0 to summation
				end-if
			end-perform
			move 1 to eof-switch
			close ifile
*	If the user enters a roman numeral, just get its value
		else
			perform getvalue
			display "Decimal Value: " summation
			display ""
		end-if		
	end-perform
		
	stop run.

getvalue.

*	Keep looping until at the end of the roman numeral
	perform until letter(i) = ' ' or invalidFlag = 1

		evaluate letter(i)
			when 'I'
				move 1 to val
			when 'V'
				move 5 to val
			when 'X'
				move 10 to val
			when 'L'
				move 50 to val
			when 'C'
				move 100 to val
			when 'D'
				move 500 to val
			when 'M'
				move 1000 to val
			when other
				display "Invalid Roman Numeral."
				move 1 to invalidFlag
		end-evaluate

		add val to summation

		if val > prev then
			compute summation = summation - 2 * prev
		end-if

		add 1 to i
		move val to prev

	end-perform.

