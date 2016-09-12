(*ML module system =
- structure : collections of types,datatypes,functions,exceptions 
and other elements we wish to encapsulate

- signature : collection of infomation describing the types and other specifications
for some of the elements of a structure

- functors : operations that take as arguments one or more elements such as structures
and produce a structure that combines the functor's arguments in some way.	
*)

signature INT = sig
	val toString:int->string
end

signature REAL = sig
	val toString:real->string
end

functor Foo (structure I:INT;
			 structure R:REAL;val x:int) = 
struct
	fun toString(i,r) =
		I.toString(i) ^ R.toString(r) ^ Int.toString(x);
end

structure Fooir =  Foo(structure I=Int;structure R = Real;val x=213);
Fooir.toString(3,3.5);

(*Sharing
	sharing type <type 1> = <type 2> = ... = <type n>
	sharing structure <structure 1> = <structure 2> = ... <structure n>
*)

(*eqtype means equality type*)

signature ELEMENT = sig
	type t;
	val similar : t * t -> bool;
end;

signature BTREE = sig
	structure Element : ELEMENT;
	eqtype elt;
	sharing type elt = Element.t;(*Element.t is forced to be an equality type*)
	datatype btree = Empty | Node of elt * btree * btree;
	val leaf : elt -> btree;
	val build : elt * btree * btree -> btree;
	val lookup : elt * btree -> bool
end

(*Opaque Signatures :>
	An opaque signature si attached to a structure by using the symbol :> rather than : .
	The significance of using :> is that
	type defined abstractly in the signature are not available outside the structure
	in which those types are used;
*)

signature SIG1 = sig
	val i : int;
	type t;
	val x : t
	val y : t
	val f : t * t ->bool
end

structure Struct1 = struct
	val i = 3;
	type t = int;
	val x = 4;
	val y = 5;
	fun f(a,b) = (a=b)
end

structure Struct2 : SIG1 = Struct1;
(*ML knows t is int,so OK to evaluate f(x,i) *)

structure Struct3 :> SIG1 = Struct1;
(*ML doesn't know t is int,evaluating f(x,i) results in an error *)

(*In both case ,ok to evaluate f(x,y),They are both of type t*)