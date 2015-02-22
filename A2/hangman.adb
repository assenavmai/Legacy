-- Game of hangman written by Dave Ahl, Digital
-- Based on a basic program written by Ken Aupperle, Half Hallow Hilla H.S. Dix Hills NY
-- Converted to Fortran 77 by M.Wirth, April 2012
-- Converted to Ada by Vanessa White, February 2015

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

procedure Hangman is

str : constant string := "jedi";
line : string(1..5);
len, i: integer := 0;
type tab is array(1..1000) of unbounded_string;
p : tab;
s : unbounded_string;

begin

put(str);new_line;

line := "hello";
put(line);

--Getting the string length of the word

for i in 1..5 loop
	get_line(s);
	p(i) := s;
	put_line(p(i));
	put(length(s));
end loop;

end Hangman;
