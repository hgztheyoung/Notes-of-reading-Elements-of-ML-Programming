(*
a type vairable,such as 'a actually has two meanings that differ subtly.
1, 'a for every type T,there's an instance of this object
with type T in place of 'a. Such a type varible is called to be 
generalizable.

2,'a can be ant one type that we choose,but once that type is selected,
the type cannot change,even if we reuse the object whose type
was described using the type variable 'a. A type of this kind is
nongeneralizable.

ML97 is conservative about allowing the generalizabel interpretation for type 
variables.

In general,we can build nonexpansive expressions bt following rules:
1, A constant or a variable is nonexpansive.
2, A function defination is nonexpansive.
3, A tuple of nonexpansive expressions is nonexpansive.
4, Example 5.14

expressions that are not of there forms are expansive and 
not allowed to have type varibles.
*)

fun id x = x;

id (id);  (*Not so cool*)
(*
Warning: type vars not generalized because of
value restriction are instantiated to dummy types (X1,X2,...)
val it = fn : ?.X1 -> ?.X1
*)
(*
我的理解，函数参数不是 nonexpansive 的，所以不能有带type varible的参数
这里的id当参数，且带type varible了，所以id(id)带着一个nongeralizable 的type variable.

一句话来说，不能把type varible 传给 type varible ?不确定 
*)

id(id:int->int); (*OK*)


(id,id); (*OK*)


SOME id;  (*OK*)
(*Example 5.14 Another way to build nonexpansive expressions is with 
the data constructors that are associated with datatypes.
*)



let 
	val x = id id 
in
	x 1 
end;        (*OK*)
(*
 id(id) as an expression is illegal at the top level.
 However,here id(id) is a subexpression,so we do not trigger the objection for now,
 Since the one type to which x applies is found in the expression x(1) to be int.
 ML finds no problem with the expression as a whole.
 In fact,the complete expression has no type varible in its type,
 so the issue does not come up.
*)


(*

let 
	val x:'a->'a = id id 
in
	(x 1,x("a")) 
end;
*)(*error*)
(*
The interpretation of its type variable is that one and only one type may ever be substituted
for that variable.There, we try to use x twice to stand for the id applied to different types.
That is,the variable 'a in the type 'a->'a of x is bound to int when ML encounters the expresison X(1).
When x is next to the argument "a", it is to late to change the value of 'a, so we are trying to 
apply int->int to string and get an error.
*)

(*
Operators that Restrict Poly
	1, +,-,*,~
	2,/,div/mod
	3, < <= >= >
	4,andalso orelse not
	5,string concatenation  ^
	6,Type conversion operators such as
	ord,chr,real,str,floor,ceiling,round,truncate
*)

(*
Operators that allow Poly
	1,Tuple operators (, ... ,) #1 #2 ...
	2,list operators :: @ hd tl nil [...]
	3,equality operators
		= equal
		<> inequal where in x<>y,x and y are the same type
*)

val x = [1,2];
val y = [3,4,5];
x=y;	(*false*)
x<>y;	(*true*) 
1<>1	(*false*)

(*
functions can't be compared for equality
The problem is that equality or inequality can only be tested
among pairs of the same  equality type,and no function type is an equality type.
- basic types are equality type
- list of equality type is equality type
- tuple of equality type is equality type 
*)

(*
id=id;
 Error: operator and operand don't agree [equality type required] 
 operator domain: ''Z * ''Z   
 operand:         ('Y -> 'Y) * ('X -> 'X)

 ''Z means equality type
*)

null([fn x=> x]); (* OK *)
  (* null is a builtin function 
  who judges whether a list is empty regardless of
  whether its a equality type list *)

(*[fn x=> x] = nil;*)  (*error*)

fun F x = x+3;
fun G y = y*y + 2*y;
val H = G o F;  (* H(x) = G(F(x)) *)

fun compC F G x = G(F(x))