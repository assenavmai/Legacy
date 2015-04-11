-- Ackermann iterative function using stacks
-- Uses stack.ads and stack.adb to implement the stack
-- Vanessa White, 2015

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Text_IO; use Ada.Text_IO;
with stack; use stack;

procedure ackermannIter is
	
	-- Declaring variables
	type Proc_Access is access function(X : in Integer; Z : in Integer) return integer;
	result, poppedVal, m, n, tempN : integer;

	function Time_It(Action : Proc_Access; Arg1 : Integer; Arg2 : Integer) return Duration is
		Start_Time : Time := Clock;
		Finis_Time : Time;
		Func_Arg1 : Integer := Arg1;
		Func_Arg2 : Integer := Arg2;

		begin
		--Action(Func_Arg1, Func_Arg2);
		Finis_Time := Clock;
		return Finis_Time - Start_Time;
	end Time_It;

	 	-- Iterative function for ackermann
	function ackermann(m : integer; n : integer) return integer is
	begin

		push(m);
		tempN := n;
		
		while stack_is_empty = false loop
			pop(poppedVal);

			if(poppedVal = 0) then
				tempN := tempN + 1;
			elsif(tempN = 0) then
				tempN := 1;
				push(poppedVal - 1);
			else
				tempN := tempN - 1;
				push(poppedVal - 1);
				push(poppedVal);
			end if;
		end loop;

		return tempN;
	end ackermann;


   Ack_Access : Proc_Access := ackermann'Access;

begin
	
	put("Enter m: ");
	get(m);

	put("Enter n: ");
	get(n);

	result := ackermann(m,n);

	new_line;
	put("Result: ")
	put(integer'image(result));
	new_line;
	Put_Line("Time Taken: " & Duration'Image(Time_It(Ack_Access, m,n)) & " seconds.");

end ackermannIter;