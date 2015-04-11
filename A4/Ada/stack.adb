-- Stack Module
-- Taken from Ada notes on the course website
-- Size of the array was the same as the C code
with Ada.Text_IO; use Ada.Text_IO;

package body stack is

	-- Declare the stack array, elements and the top of the stack
	type stackArray is array(1..1000000) of integer;
	type q_stack is
		record
			item : stackArray;
			top : integer := 0;
		end record;

	st : q_stack;

	-- Push procedure, pushes an element onto the stack as long as it is not full
	procedure push(x : in integer) is
	begin
		if st.top >= 999999 then
			put_line("Stack is full");
		else
			st.top := st.top + 1;
			st.item(st.top) := x;
		end if;
	end push;

	-- Pop procedure, removes the top of the stack as long as the stack is not empty
	procedure pop(x : out integer) is
	begin
		if st.top = 0 then
			put_line("Stack is empty");
		else
			x := st.item(st.top);
			st.top := st.top - 1;
		end if;
	end pop;

	-- Checks if the stack is empty
	function stack_is_empty return Boolean is
	begin
		return st.top = 0;
	end stack_is_empty;

	-- Peek function, returns the value of the top of the stack
	function stack_top return integer is
	begin
		if st.top = 0 then
			put_line("Stack is empty");
			return 0;
		else
			return st.item(st.top);
		end if;
	end stack_top;

	-- Remove everything from the stack
	procedure reset_stack is
	begin
		st.top := 0;
	end reset_stack;

end stack;