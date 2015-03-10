* Program to convert roman numerals to its equivalent decimal value.
* Migrated from older Cobol code.
* Author: Vanessa White
* Course: CIS*3190
* Date last edited: March 8th, 2015.

identification division.
program-id. conv.
environment division.
input-output section.
file-control.
	select standard-input assign to keyboard.
	select standard-output assign to display.
data division.
file section.
fd standard-input.
	01 stdin-record    picture x(80).
fd standard-output.
	01 stdout-record   picture x(80).
working-storage section.
01 array-area.
	02 letter pic X(1) occurs 30 times.
77	i pic S99 usage is computational.
77 dumb pic S99 usage is computational.
procedure division.

	open input standard-input, output standard-output.
	display "Enter Roman Numerals Please: " with no advancing

	move 0 to dumb.
	move 1 to i.

	perform until i > 10
		accept letter(i)
		display letter(i)
	end-perform.


*		display "Fuck me: " with no advancing
*		accept letter(i)
*	display letter(i)
