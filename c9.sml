(*Summary of the ML Standard Basis*)

(*The Infix Operators*)

(*

+-----------+-----------+---------------------------+
|Precedence	|Operator	|Comments					|
+-----------+-----------+---------------------------+
|	0		|before		|Second argument excuted	|
|			|			|only for side-effects		|
+-----------+-----------+---------------------------+
|	3		|o 			|Function compsition		|
|			|:=			|Assignment for ref values	|
+-----------+-----------+---------------------------+
|	4		|=,<>,<		|Comparasion Operators		|
|			|>,<=,>=	|							|
+-----------+-----------+---------------------------+
|	5		|::,@		|cons and cat for lists		|
+-----------+-----------+---------------------------+
|	6		|+,-,^		|^ is string cat			|
+-----------+-----------+---------------------------+
|	7		|*,/,div,mod|Multiplicative operator	|
+-----------+-----------+---------------------------+

*)

fun f x = x before print("hello!\n");
fun f1 x = (print("Naive!\n");x);

(*Creating New Infix Operators
	infix <level> <identifier list>
- use infixr to create right-associative op
- Omitting <level> can crate operator with 0 level
- use nonfix to remove infix property from identifiers
- use op to trun an identifier temporarily in to a nonfix function
*)

(*assumes 0<=m<=n *)
fun comb (n,m) =
	if m=0 orelse m=n then 1
	else comb(n-1,m) + comb(n-1,m-1)

infix 2 comb;
5 comb 2 comb 4;
(*
- comb(5,2);
stdIn:1.2-1.6 Error: expression or pattern begins with infix identifier "comb"
*)
nonfix comb;

open Array;
infix 3 sub;
val a = Array.fromList([1,4,7,10]);
val y = a sub 2 + 1;  (*10,Precedence of + is higher than 3,(sub a (+ 2 1)) *)

(*Infix Data Constructors*)

datatype 'a btree = 
	T of 'a btree * 'a btree
|	Leaf of 'a;
infix 2 T;
val t = Leaf (1) T Leaf (2) T Leaf (3)
(* t is the same as
	(T (T (Leaf 1)
		  (Leaf 2))
	   (Leaf 3))
*)

fun printTree (Leaf(i)) =
	print("(Leaf "^Int.toString(i)^")")
|	printTree (t1 T t2) =	(
	print "(T ";
	printTree t1;
	print(" ");
	printTree t2;
	print ")\n"
)	

(*Functions in the Top-level Environment
open Int;
	~,abs
	real:convert an integer to an quivalent real
	chr: convert an integer to the character with that integer as its ASCII code.
open Real;
	~,abs
	floor,ceil,trunc,round:convert real to approximately equivalent integers in various ways.
open Bool;
	andalso,orelse,not
open Char;
	ord,str,implode
open String;
	^,explode,concat,size,substring
open Options;
	getOpt(SOME 3,4);
	getOpt(NONE, 4);
open Ref;
open List;
funs on exception
	exnName :exn -> string  the name of the exception Constructors
	exnMessage : exn -> string 
	the infomation the system will produce if that exception is not handled by the program,
	This message is implementation depedent.

ignore 1;
(1);

datatype order = LESS | EQUAL | GREATER

open Word;
the type word in ML designates unsigned integers.

open Math;

open Substring;
A substring is an abstraction whose values are not visiable to the programmers.
We may think of a value of tyep substring as 
string 		*	 int	 						* int
base string		position where substring begins		length of substring

*)

val ss = Substring.substring("abcdefg",2,4);
(*no value for this substring is visible,
The true representation is some internal,implementation-depedent data structure*)
Substring.base ss;

(*
open Array;

open Vector;
type constructor vector creates immutable arrays of elemetns of a certain type.
*)

val v = #[1,2,3];

(*
open OS;
open Time;open Timer;
open General;
*)