fun upper(c) = 
	chr(ord(c) - 32)

fun take (l) =
	if l = nil then nil
	else hd(l)::skip(tl(l))
and
	skip (l) =
		if l=nil then nil
		else take(tl(l));

take([1,2,3,4,5]);

fun ret3 () = (1,2,3)

val (x,y,z) = ret3();

fun reverse(l) = 
	let 
		val rec rev1 = fn (l,res) =>  
		case l of
			nil => res
			| x::xs => rev1(xs,x::res)
	in
		rev1(l,nil)
	end

fun cat (l,m) =
	let
		val revl = reverse l
		fun r nil l = l
		|	r (ar::dr) l = r dr (ar::l)		
	in
		r revl m
	end

fun cycle (l,i) = 
	let
		fun split l res 0 = (reverse res,l)
		  | split (ar::dr) res i = 
			split dr (ar::res) (i-1)
		val (l1,l2) = split l nil i 
	in
		cat(l2,l1)
	end
			