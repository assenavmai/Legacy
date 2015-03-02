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
    j : integer := 1;
    word_guess : string(1..len);
    tries_remaining : integer := 0;
    filestr : unbounded_string;
    infp : file_type;
    outfp : file_type;
    flag_correct, flag_used, winner, flag_word, flag_incorrect : Boolean := false;
    --person : string(1..10) := ("head", "body", "r arm", "l arm", "r leg", "l leg", "r hand", "l hand", "r feet", "l feet");
    type arr is array (1..1000) of unbounded_string;
    word_progress, correct_word : string(1..15);
    letters_used : string(1..26);
    wordarr : arr;
    dest : arr;
    type rndRange is new integer range 1..200;
    package rnd is new Ada.Numerics.Discrete_Random(rndRange);
    rndGenerator : rnd.Generator;
    num : rndRange;
    ch, guess : character;


    function isGuessCorrect(correct: string; length: integer; c: Character) return integer is
        begin

        for i in 1..length loop
            if correct(i) = c then
                put("pie");
                return 1;
            end if;
        end loop;
        return 0;
    end isGuessCorrect;
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
    open(infp, in_file, "dict.txt");

        for i in 1..rndnum loop
            exit when end_of_line(infp);
            get_line(infp, filestr);
            --put_line((wordarr(i)));
            len := length(filestr);
            --put(len);
            --put(filestr);
            --put(wordarr(i));
            --new_line;
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
           --put(ch);
            if end_of_line(infp) then 
                new_line;
            end if;
            --new_line;
        end loop;

    close(infp);


    --Out put the length of the word for the user
    --Initialize wordprogress to underscores
    for i in 1..len loop
        word_progress(i) := '_';
       -- put(word_progress(i));
      --  put(' ');
    end loop;
    new_line;

    --Initialize letters used to spaces
    for i in 1..26 loop
        letters_used(i) := ' ';
    end loop;


    while tries_remaining < 10 loop

        for i in 1..len loop
            put(word_progress(i));
            put(' ');
        end loop;
        new_line;

        put("Letters used: ");
        for i in 1..j loop
            put(letters_used(i));
            put(' ');
        end loop;
        new_line;

        new_line;
        put("Enter a guess: ");
        get(guess);

        for i in 1..26 loop
            exit when flag_used = true;
            if(letters_used(i) = guess) then
                flag_used := true;
                put("used");
            end if;
        end loop;

        if flag_used = false then
            for i in 1..len loop
                if(correct_word(i) = guess) then
                    flag_correct := true;
                    word_progress(i) := guess;
                end if;
            end loop;
        letters_used(j) := guess;
        j := j + 1;
        else
            put("You already have guessed that letter. Try again");
            new_line;
        end if;

        if flag_correct = true then
            put("Enter a guess for the word: ");
            for i in 1..len loop
                exit when flag_incorrect = true;
                get(ch);
                if(correct_word(i) = ch) then
                    flag_word := true;
                else
                    put("Sorry, that was not the correct word.");
                    flag_incorrect := true;
                    flag_word := false;
                end if;
            end loop;
        else
            new_line;
            tries_remaining := tries_remaining + 1;
        end if;


        if flag_word = true then
            new_line;
            put("You guessed the correct word!");
            new_line;
        end if;


            new_line;





        flag_used := false;
        flag_correct := false;
    end loop;

    if(tries_remaining >= 10) then
        put("You got hung!");
        new_line;
        put("Sorry, you lose.");
        new_line;
        put("The word was: ");
        put(filestr);
    end if;

   

end Hangman;
