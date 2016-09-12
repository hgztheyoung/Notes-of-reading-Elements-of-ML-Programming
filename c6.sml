(*
- type definitions are shorthands or macros for
previous defined type expressions

- datatype definitions are rules for constructing new types
with new values that are nor the values of previous
defined types
*)

(*
	Types in ML are defined recursively, (recursive type?)	
*)

(*BASIS
	int real string char bool unit exn instream outstream

	a type varible 'a(any type) or ''a(equality type) can serve in place of a
	constant type(type without a type varible?) such as int.	
*)

(*INDUCTION
	1, product type	
		T1 * T2 * ... * Tn
	2,function type
		T1 -> T2
	3,type constructors
		list      [1,2,3] [true,false] 
		option    SOME "Naive 213"
		ref	      ref 1
		array vector
*)

(*New Name for Old Types*)
type signal = real list;
val v = [1.0 ,2.0] : signal;

val w = [1.0,2.0]; (*real list*)

(*v=w;*)  (*error in SML/NJ, while the book says it evaluates to be true in ML 97*)

type ('k , 'v) mapping = ('k * 'v) list;

val words = [("in", 6),("a",1)] : (string,int) mapping

(*datatype
The concept of datatypes gemeralizes such ideas as enumerated types
or union tyeps in C or Pascal,but goes far beyond these.
*)

datatype fruit = Apple | Pear | Grape;

fun isApple(x) = x=Apple

datatype ('a,'b) element =
	P of 'a * 'b 
	| S of 'a;

[P(1,"s"),S 2];
[P(#"s",Apple),S #"z"];

fun sumEllist nil = 0
|	sumEllist(S(x)::L) = 1+sumEllist(L)
|	sumEllist(P(x,y)::L) = y+sumEllist(L)


(*Recursive Defined Datatypes*)

datatype 'label btree =
	Empty
|	Node of 'label * 'label btree * 'label btree
;
Node (2,
		Node(1,Empty,Empty),
		Node(3,Empty,Empty));

datatype
	'a evenList = 
	EmptyNode
|	Enode of 'a * 'a oddList
and
	'a oddList = 
	Onode of 'a * 'a evenList
;
Enode("2",Onode("1",Enode("3",Onode("!",EmptyNode))))