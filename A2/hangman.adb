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

    len, i, rndnum, n: integer := 0;
    filestr : unbounded_string;
    infp : file_type;
    outfp : file_type;
    type arr is array (1..1000) of unbounded_string;
    wordarr : arr;
    type rndRange is new integer range 1..3;
    package rnd is new Ada.Numerics.Discrete_Random(rndRange);
    rndGenerator : rnd.Generator;
    num : rndRange;
    ch : character;

begin

    --Generate a random number
    rnd.Reset(rndGenerator);
    num := rnd.Random(rndGenerator);
    --put_line(rndRange'image(num));

    --Store the random number into a file (couldn't figure out how to use the number for my loop)
    create(outfp, out_file, "num.txt");
    put(outfp, rndRange'image(num));
    close(outfp);

    --Open the file with the random number and store it into an integer type
    open(infp, in_file, "num.txt");
        loop
            exit when end_of_file(infp);
            get(infp, rndnum);
            --put(rndnum);new_line;
        end loop;
    close(infp);

    --Open a file with words to use and randomly choose one
    open(infp, in_file, "test.txt");

        for i in 1..rndnum loop
            exit when end_of_line(infp);
            get_line(infp, filestr);
            --put_line((wordarr(i)));
            len := length(filestr);
            --put(len);
            --put(filestr);
            --put(wordarr(i));
            new_line;
        end loop;
    close(infp);

        put("File str ");
        put(filestr);new_line;
        put("Length");
        put(len);new_line;       

        create(outfp, out_file, "word.out");
        put(outfp, filestr);
        close(outfp);

    open(infp, in_file, "word.out");
        for i in 1..len loop
            exit when end_of_file(infp);
            get(infp, ch);
            put(ch);
            if end_of_line(infp) then 
                new_line;
            end if;
            new_line;
        end loop;
    close(infp);

    put(ch);

end Hangman;
