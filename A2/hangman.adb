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

    len, i, rndnum, n, correct_guesses, incorrect_guesses: integer := 0;
    tries_remaining : integer := 0;
    filestr : unbounded_string;
    infp : file_type;
    outfp : file_type;
    flag_correct, flag_incorrect, winner : Boolean := false;
    --person : string(1..10) := ("head", "body", "r arm", "l arm", "r leg", "l leg", "r hand", "l hand", "r feet", "l feet");
    type arr is array (1..1000) of unbounded_string;
    word_progress, correct_word : string(1..15);
    guessed_letter : string(1..10);
    wordarr : arr;
    type rndRange is new integer range 1..3;
    package rnd is new Ada.Numerics.Discrete_Random(rndRange);
    rndGenerator : rnd.Generator;
    num : rndRange;
    ch, guess : character;

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

    --Create a file with the word that is going to be used in the game
    create(outfp, out_file, "word.out");
    put(outfp, filestr);
    close(outfp);

    --Store the word into an array, character by character
    open(infp, in_file, "word.out");

        for i in 1..len loop
            exit when end_of_file(infp);
            get(infp, ch);
            correct_word(i) := ch;
            put(ch);
            if end_of_line(infp) then 
                new_line;
            end if;
            new_line;
        end loop;

    close(infp);

    --Out put the length of the word for the user
    --Initialize wordprogress to underscores
    for i in 1..len loop
        word_progress(i) := '_';
        put(word_progress(i));
        put(' ');
    end loop;
    new_line;

    while tries_remaining < 10 loop

        put("Tries left: "); set_col(2);put(tries_remaining); new_line;
        put("Incorrect Guesses: "); put(incorrect_guesses); new_line;
        put("Correct Guesses: "); put(correct_guesses); new_line;
        put("Enter your guess: ");
        get(guess);

        for i in 1..len loop
            if correct_word(i) = guess then
                word_progress(i) := guess;
                correct_guesses := correct_guesses + 1;

                if correct_guesses = len then
                    put("Congrats, you got the word");
                    new_line;
                    winner := true;
                end if;

                flag_correct := true;
            end if;

            exit when correct_guesses = len;
        end loop;

        if(flag_correct /= true) then
            incorrect_guesses := incorrect_guesses + 1;
            guessed_letter(1) := guess;
            tries_remaining := tries_remaining + 1;
        end if;

        if(incorrect_guesses > 10) then
            exit;
        end if;
        
        for i in 1..len loop

            put(word_progress(i));
            put(' ');
        end loop;
        new_line;

        for i in 1..len loop
            put(correct_word(i));
            put(' ');
        end loop;
        new_line;

        flag_correct := false;
        
        exit when winner = true;
    end loop;

end Hangman;
