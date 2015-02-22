-- Game of hangman written by Dave Ahl, Digital
-- Based on a basic program written by Ken Aupperle, Half Hallow Hilla H.S. Dix Hills NY
-- Converted to Fortran 77 by M.Wirth, April 2012
-- Converted to Ada by Vanessa White, February 2015

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.Numerics.discrete_Random;

procedure Hangman is

	str : constant string := "jedi";
	len, i: integer := 0;
	filestr : unbounded_string;
	fp : file_type;
	type arr is array (1..1000) of unbounded_string;
	wordarr : arr;
	type rndRange is range 1..3;
	package rnd is new Ada.Numerics.Discrete_Random(rndRange);
	rndGenerator : rnd.Generator;
	num : rndRange;

begin

	rnd.Reset(rndGenerator);
	num := rnd.Random(rndGenerator);
	put_line(rndRange'image(num));

	open(fp, in_file, "test.txt");

		for i in 1..5 loop
			exit when end_of_line(fp);
			get_line(fp, filestr);
			wordarr(i) := filestr;
			put_line((wordarr(i)));
			len := length(filestr);
			put(len);
			put(filestr);
			put(wordarr(i));
			new_line;
		end loop;
	close(fp);


end Hangman;
