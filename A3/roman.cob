* Program to convert roman numerals to its equivalent decimal value.
* Migrated from older Cobol code.
* Author: Vanessa White
* Course: CIS*3190
* Date last edited: March 8th, 2015.

identification division.
program-id. cob.
environment division.
input-output section.
file-control.
	select standard-input assign to keyboard.
	select standard-output assign to display.
	select ifile assign to "numeral.in"
		organization is line sequential.
data division.
file section.
fd standard-input.
	01 stdin-record    pic x(80).
fd standard-output.
	01 stdout-record   pic x(80).
fd ifile.
	01 input-record.
		05 numeral 	pic x(1) occurs 30 times.
working-storage section.
01 array-area.
	02 letter pic x(1) occurs 30 times.
77	i pic S99 usage is computational.
77	val pic S9(4) usage is computational.
77	summation pic S9(8) usage is computational.
77 	prev pic S9(8) usage is computational.
77 	str pic x(30).
77	eof-switch pic 9 value 1.
procedure division.

	open input standard-input, output standard-output.

	display ""
	display "Welcome to the Roman Numeral Convertor."
	display "Enter a roman numeral statement and it will be converted to its equivalent decimal value"
	display "Enter 'f' at anytime to read a file and convert the roman numeral values"
	display "Enter 'q' at anytime to quit."
	display ""

perform until letter(i) = 'q'

	move 0 to prev
	move 1 to i
	move 0 to summation

	display "Enter roman numerals, read a (f)ile or (q)uit: " with no advancing
	accept array-area

	perform until letter(i) = ' '

		move 0 to val

		if letter(1) = 'q' then
			display ""
			display "You chose to quit. Goodbye."
			stop run
		end-if

		if letter(1) = 'f' then
			display ""
			display "You chose to read from a file."

			open input ifile

			perform
				until eof-switch = 0
				read ifile into array-area
					at end move 0 to eof-switch
				end-read

				if eof-switch is not = 0
					display array-area
				end-if
			end-perform
			close ifile
		end-if

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
		end-evaluate

		 add val to summation

		if val > prev then
			compute summation = summation - 2 * prev
		end-if

		add 1 to i
		move val to prev

	end-perform
	display "Decimal Value: " summation
	display ""
end-perform
	
stop run.

