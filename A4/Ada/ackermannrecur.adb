with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Text_IO; use Ada.Text_IO;

procedure ackermannrecur is

	type Proc_Access is access function(X : in Natural; Z : in Natural) return Natural;
	result, m, n: integer;

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
	
	function Ackermann (M, N : Natural) return Natural is
		begin
			if M = 0 then
				return N + 1;
			elsif N = 0 then
				return Ackermann (M - 1, 1);
			else
				return Ackermann(M - 1, Ackermann(M, N - 1));
			end if;
	end Ackermann;

   	Ack_Access : Proc_Access := Ackermann'Access;


begin 
	
	put("Enter m: ");
	get(m);

	put("Enter n: ");
	get(n);
	for i in 0..m loop
		for j in 0..n-m loop
			result := Ackermann(m,n);
		end loop;
	end loop;

	new_line;
	put("Result: ");
	put(integer'image(result));
	new_line;
	Put_Line("Time Taken: " & Duration'Image(Time_It(Ack_Access, m,n)) & " seconds.");


	
end ackermannrecur;
