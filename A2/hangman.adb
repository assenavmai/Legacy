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

    progression, used, len, i, j, rndnum, correct_guess: integer := 0;
    k : integer := 1;
    tries_remaining : integer := 0;
    filestr : unbounded_string;
    infp : file_type;
    outfp : file_type;
    flag_again : Boolean := true;
    type arr is array (1..1000) of unbounded_string;
    word_progress, correct_word : string(1..15);
    letters_used : string(1..26);
    
    type rndRange is new integer range 1..200;
    package rnd is new Ada.Numerics.Discrete_Random(rndRange);
    rndGenerator : rnd.Generator;
    num : rndRange;
    ch, guess, play_again : character;
    type BoardType is array(1..11, 1..11) of Character;
    board : BoardType;


-- A function that checks if the letter they entered is correct. If yes, return 1. No? Return 0.
    function isGuessCorrect(correct: string; length: integer; c: Character) return integer is
        begin

        for i in 1..length loop
            if(correct(i) = c) then
                return 1;
            end if;
        end loop;
        return 0;

    end isGuessCorrect;

-- Checks if the user repeated a guess. If yes, 
    function isLetterUsed(guessed_letters: string; c: Character) return integer is
        begin

        for i in 1..26 loop
            if(guessed_letters(i) = c) then               
                return 1;
            end if;
        end loop;
        return 0;

    end isLetterUsed;

-- A function that checks if they guessed all the letters. If yes, return 1. No, return 0;
    function isDone(progression_str: string; length: integer) return integer is
        begin

            for i in 1..length loop
                if(progression_str(i) = '_') then
                    return 0;
                end if;
            end loop;

            return 1;

    end isDone;

-- Procedure that puts fills up the empty lines if they guess a correct answer
    procedure showProgress(final_word: in string; guessed_letters: in string; progression_str: out string; length: in integer; guess_len: in integer) is
    begin
        
        for i in 1..length loop
            for j in 1..guess_len loop
                if(final_word(i) = guessed_letters(j)) then
                    progression_str(i) := guessed_letters(j);
                end if;
            end loop;
        end loop;

    end showProgress;

--Procedure that draws the hangman depending on how many incorrect guesses they do
    procedure drawMan(wrong_guesses: in integer; arr : out BoardType) is
    begin

        case wrong_guesses is
            when 1 =>
                arr(3,7) := 'o';
            when 2 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
            when 3 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
            when 4 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
            when 5 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
            when 6 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
                arr(5,8) := '\';
            when 7 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
                arr(5,8) := '\';
                arr(4,9) := '_';
            when 8 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
                arr(5,8) := '\';
                arr(4,9) := '_';
                arr(4,5) := '_';
            when 9 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
                arr(5,8) := '\';
                arr(4,9) := '_';
                arr(4,5) := '_';
                arr(5,9) := '_';
            when 10 =>
                arr(3,7) := 'o';
                arr(4,7) := '|';
                arr(4,6) := '/';
                arr(4,8) := '\';
                arr(5,6) := '/';
                arr(5,8) := '\';
                arr(4,9) := '_';
                arr(4,5) := '_';
                arr(5,9) := '_';
                arr(5,5) := '_';
            when others =>
                null;
        end case;

        for i in 1..9 loop
            for j in 1..9 loop
                put(arr(i,j));
            end loop;
            new_line;
        end loop;

    end drawMan;



begin

-- Continue to loop while the user enter 'y'
    while(flag_again = true) loop

        new_line;
        put("Hangman: The Game");
        new_line;

        for i in 1..9 loop
            for j in 1..9 loop
                board(i,j) := ' ';
            end loop;
         end loop;

        for j in 2..9 loop
            board(1,j) := 'x';
        end loop;

        for i in 1..8 loop
            board(i,1) := 'x';
        end loop;

        for j in 1..9 loop
            board(9,j) := '=';
        end loop;

        board(2,7) := '|';

--Generate a random number
        rnd.Reset(rndGenerator);
        num := rnd.Random(rndGenerator);

--Store the random number into a file (couldn't figure out how to use the number for my loop)
        create(outfp, out_file, "num.txt");
        put(outfp, rndRange'image(num));
        close(outfp);

--Open the file with the random number and store it into an integer type
        open(infp, in_file, "num.txt");
            loop
                exit when end_of_file(infp);
                get(infp, rndnum);
            end loop;
        close(infp);

--Open a file with words to use and randomly choose one
        open(infp, in_file, "dict.txt");

            for i in 1..rndnum loop
                exit when end_of_line(infp);
                get_line(infp, filestr);
                len := length(filestr);
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
                if end_of_line(infp) then 
                    new_line;
                end if;
            end loop;

        close(infp);


--Out put the length of the word for the user
--Initialize wordprogress to underscores
        for i in 1..len loop
            word_progress(i) := '_';
        end loop;
        new_line;

--Initialize letters used to spaces
        for i in 1..26 loop
            letters_used(i) := ' ';
        end loop;


-- Keep looping unless the user exhausts all their tries or they filled in the word
        while tries_remaining < 10 and progression = 0 loop

-- print out what they current found in the word
            for i in 1..len loop
                put(word_progress(i));
                put(' ');
            end loop;
            new_line;

-- print out what letters they have guessed before
            new_line;
            put("Letters used: ");
            for i in 1..k loop
                put(letters_used(i));
                put(' ');
            end loop;
            new_line;

-- Prompt the user to enter a guess. A guess may be a letter or a word
            new_line;
            put("Enter a guess: ");
            get(guess);

        --Call the functions to check if the letter has already been guesses and if they letter is correct
            used := isLetterUsed(letters_used, guess);
            correct_guess := isGuessCorrect(correct_word, len, guess);

        --If the letter was not guessed before, add it to the array
            if(used =  0) then
                letters_used(k) := guess;
                k := k + 1;

            --If the letter is correct then fill in the blanks
                if(correct_guess = 1) then
                    showProgress(correct_word, letters_used, word_progress, len, k);

            --If not, their tries remaining increase by one and draw the appropiate hangman part
                else
                    tries_remaining := tries_remaining + 1;
                    drawMan(tries_remaining, board);
                end if;
            else
                new_line;
                put("You already guessed that letter!");
                new_line;
            end if;

        --Check if the word is finished
             progression := isDone(word_progress, len);

        --If the word is finished, then show the word and end the game
             if(progression = 1) then
                showProgress(correct_word, letters_used, word_progress, len, k);
            end if;

        end loop;

    --If the user exhausted their tries, tell them they lose and print out the word
        if(tries_remaining >= 10) then
            put("You got hung!");
            new_line;
            put("Sorry, you lose.");
            new_line;
            put("The word was: ");
            put(filestr);
            new_line;
        end if;

    --If they won, tell them they won!
        if(progression = 1) then
            put("You guessed the correct word!");
            new_line;
        end if;

    --Prompt the user to play again. 
        put("Would you like to play again?(y/n): ");
            get(play_again);

        if(play_again = 'y') then
            flag_again := true;
        else
            new_line;
            put("Thanks for playing! Goodbye :-).");
            flag_again := false;
        end if;

        tries_remaining := 0;
        progression := 0;
        k := 1;

    end loop;
   

end Hangman;
