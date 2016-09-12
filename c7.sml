val recordofJack = {
	ID = 123,
	name = "Micheal Jackson",
	courses=["CS107","CS110"]
};
#name(recordofJack);

(*the order of the element in a record doesn't make a difference
	{x:int,y:int} is the same as
	{y:int,x:int}
*)

(*Tuple is a Special Case of Record Structures

(<value 1>,<value 2>,...,<value n>)
is really a shorthand for the record
{1=<value 1>,2=<value 2>,...,n=<value n>}
*)

exception NotFound;
fun getID(person,nil) = raise NotFound
|	getID(person,(x as {name=p,...})::xs) =
		if p = person then
			#ID(x:{name:string,ID:int,courses:string list})
		else
			getID(person, xs)

(* x as {name=p,...}
we can only use ... in such a way that the compiler
can deduce a unique type for an occurence of the ...

a pattern with a ... must have the same type
*)

fun tuition({name=_, ID=_,courses=nil}) = 1000
|	tuition({courses=[_],...}) = 2000
|	tuition({ID=i,...}) = 
	if i>100000 then 5000 else 4000
;

(*Why Do We Need Arrays
- State
- Random Access
	open Array;
	val a =fromList([1,2,3])<==> int a[3] = {1,2,3};
	val a = array(10,0);  <==> int a[10];
	update(a,i,x)			<==> a[i] = x;
	val y = sub(a,i);		<==> int y = a[i];
*)

open Array;

fun checkAll (A,i) =
	i<0 orelse
	sub(A,i) andalso checkAll(A,i-1)

fun fillAndCheck(A,x::xs) =(
		update(A,ord(x) - ord(#"a"),true);
		fillAndCheck(A,xs)
	)
|	fillAndCheck(A,nil) = checkAll(A,25)
;

fillAndCheck(array(26,false),
			 explode("abcdef"));


(*References

val i = ref 0;
val x = i;
x := 4;
!i;
environment:
+-------+--------------------+
|	i	|		ref	(4)		 |
+-------+--------------------+
|	x	|		i			 |
+-------+--------------------+
|		|					 |
+-------+--------------------+
*)

val i = ref 0;
val x = i;
x := 4;
!i;

while !i<=10 do (
	print(Int.toString(!i));
	print(" ");
	i := !i + 1
);