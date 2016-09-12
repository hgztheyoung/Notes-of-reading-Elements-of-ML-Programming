(* < lt(x,y)
 - Transitivity 
 	lt(x,y) and lt(y,z) imply ly(x,z)
- Comparability
	If x!= y,then exactly one of lt(x,y) and lt(y,x) is true
- irreflexivity
	lt(x,x) is never true for every x
*)

datatype 'label btree = 
	Empty 
	| Node of 'label * 'label btree * 'label btree;

fun lower nil = nil
|	lower (c::cs) = (Char.toLower c)::lower(cs);

fun strLT(x,y) =
let
	val toLower = implode o lower o explode
in
	toLower x < toLower y
end;

(*Avoiding Equality Tests in Searches,use lt instead of <*)
fun lookup lt Empty x = false
|	lookup lt (Node(y,left,right)) x =
		if lt(x,y) 
		then lookup lt left x
		else if lt(y,x)	 
		then lookup lt right x
		else true
;

val t = Node("ML",
				Node("as",
					Node("a",Empty,Empty),
					Node("in",Empty,Empty)
				),
				Node("types",Empty,Empty)
		);

lookup strLT t "function";

fun insert lt Empty x = Node(x,Empty,Empty)
|	insert lt (T as Node(y,left,right)) x =
		if lt(x,y) then Node(y,(insert lt left x),right)
		else if lt(y,x) then Node(y,left,(insert lt right x))
		else T
;

insert strLT t "function";

exception EmptyTree;

fun deletemin Empty = raise EmptyTree
|	deletemin (Node(y,Empty,right)) = (y,right)
|	deletemin (Node(w,left,right)) =
		let
			val (y,L) = deletemin(left)
		in
			(y,Node(w,L,right))
		end
;

fun delete lt Empty x = Empty
|	delete lt (Node(y,left,right)) x=
		if lt(x,y) then Node(y,(delete lt left x),right)
		else if lt(y,x) then Node (y,left,(delete lt right x))
		else
			case (left,right) of
				(Empty,r) => r
				| (l,Empty) => l
				| (l,r) =>
					let val (z,r1) = deletemin(r) in
						Node(z,l,r1)
					end
;					
			
fun sum Empty = 0
|	sum (Node(a,left,right)) = a+sum(left)+sum(right);

fun preOrder Empty = nil
|	preOrder (Node(a,left,right)) =
		[a] @ preOrder(left) @ preOrder(right);


(*
insert strLT t "function";
*)
fun insertall lt t [] = t
|	insertall lt t (ar::dr) =
		let
			val newt = insert lt t ar
		in
			insertall lt newt dr
		end

