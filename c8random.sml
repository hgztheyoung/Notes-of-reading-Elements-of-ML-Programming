(*Feedback Shift Register
	pesudo random queue generator
	+---------------+-----------+---------------+
	|				|			|				|
	|				↓			↓				|				 	
	+->(1)-->(1)-->[+]-->(0)-->[+]---->(1)--> output f
		0	  1			  2				3
	In one step,do the following:
	1 Output the bit in the rightmost cell(n-1st).
	it's both the output bit and the feedback bit.
	2 Shift all the bits right one position,
	so what was in cell i moves to cell i+1 for i =0,1,2,...,n-2;
	3 Put the bit 0 in cell 0.
	4 If f = 0,do nothing else.
	If f = 1,complement(取补) evey bit except the second bit
	1000
	0100
	0010
	0001
	0000 -> 1011
	0101 -> 1110
	0111
	0011 -> 1000
*)

(*
n is the length of the register.
feed is the list showing which bits have feed back.
*)
signature RANDOM_DATA = sig
	val n:int
	val feed : int list
end

functor MakeRandom (Data : RANDOM_DATA) : 
sig
	val init : unit -> unit
	val getBit : unit -> int 
end 
= struct
	open Data;
	open Array;
	val register = array(n,0)
	fun feedback() = let
		fun feedback1 nil = ()
		|	feedback1 (x::xs) = (
				update(register,x,1-sub(register,x));
				feedback1(xs)
			);
	in
		feedback1(feed)
	end		
	fun shift() = let
			fun shift1 0 = update(register,0,0)
			|	shift1 x = (
				update(register,x,sub(register,x-1));  (*register[x] = 1-register[x-1] *)
				shift1(x-1)
			)
		in
			shift1(n-1)
		end
	fun init() = let
		fun init1 0 = (
			update(register,n-1,1);
			update(register,0,0))
		|	init1 i = (
			update(register,i,0);
			init1(i-1))		
	in
		init1(n-2)		
	end
	fun getBit() = let
		val bit = sub(register,n-1)
	in (
		shift();
		if bit=1 then feedback() else ();
		bit
	)
	end		
end

structure MyData : RANDOM_DATA = struct
	val n = 20;
	val feed = [0,2,4,6,7,14,17,19];
end

structure PseudoRandom = MakeRandom(MyData);
open PseudoRandom;

fun random i = let
	fun random1 0 = print("\n")
	|	random1 i = (
		if i mod 72 = 0 then
			print("\n")
		else ();
		print(Int.toString(getBit()));
		random1 (i-1)	
	)	
in (
	init();
	random1(i)
)
end;

random 1000  (*generate 1000 pseudo random bit*)