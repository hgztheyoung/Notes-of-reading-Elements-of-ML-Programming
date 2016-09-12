
(*Abstract type
	use abstype to define an abstract type with almost the same syntax as to define a datatype.
	However,for abstype we must  follow the keyword with 
	to introduce the only elements that have access to the data constructors.

	
	abstype sbttree = 
		Empty
		 | Node of string * sbttree * sbttree
	with
		val create = Empty;
		fun lookup(x,T) = ...;
		...
	end;	
*)

(*local is another way to write let ? *)

local
	fun id x = x;
	fun fact1 0 k = k 1
	|	fact1 n k = fact1 (n-1) (fn res => k(res*n));
in
	fun fact n = fact1 n id
end;