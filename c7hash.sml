open Array;

val b = 5;

fun h x = 
	let	
		fun h1 nil = 0
		|	h1 (x::xs) = ((ord x) + h1(xs)) mod b	
	in
		(h1 o explode) x
	end
;

fun insert(x,A) = 
let		
	fun insertList (x,nil) = [x]
	|	insertList (x,y::ys) = 
			if x=y then y::ys
			else y::insertList(x,ys);		
	val bucket = h(x);
	val L = sub(A,bucket)
in
	update(A,bucket,insertList(x,L))
end;

fun delete (x,A) = 
	let
		fun deleteList (x,nil) = nil
		|	deleteList (x,y::ys) = 
				if x=y then ys
				else y::deleteList(x,ys);
		val bucket = h(x);
		val l = sub(A,bucket)
	in
		update(A,bucket,deleteList(x,l))
	end
;
	
fun lookup (x,A) = 
	let
		fun lookupList (x,nil) = false
		|	lookupList (x,y::ys) = 
				if x=y then true
				else lookupList(x,ys);
	in
		lookupList(x,sub(A,h(x)))
	end
;	

val A = array(b,nil:string list);
insert("Naive!",A);
insert("Too Simple!",A);
insert("Angry",A);
insert("Ha",A);
insert("Jingyan",A);
lookup("Ha",A);
delete("Ha",A);
lookup("Ha",A);
A;


