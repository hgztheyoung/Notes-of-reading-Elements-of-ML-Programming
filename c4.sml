(*
- stdIn;
val it = - : instream
- stdErr;
val it = - : outstream
- stdOut;
val it = - : outstream
*)

open TextIO;

fun testZero 0 = print("zero\n")
  | testZero _ = print("not zero\n")

val c = #"a";

print(str(c));

fun printIntList [] = ()
  | printIntList (ar::dr) = (
		print(Int.toString(ar));
		print("\n");
		printIntList dr
	);
  		
val infilefoo = openIn("foo"); (*try to find foo in curent directory*)

lookahead(infilefoo);
(*closeIn (infilefoo)*)
fun readList (infile) = 
	if endOfStream(infile) then nil
	else inputN(infile,1) :: readList(infile)

fun makeList infile = let
	fun makeList1 infile NONE = nil
  | makeList1 infile (SOME s) = 
  	s :: makeList1 infile (input1(infile));	
in
	makeList1 infile (input1(infile))
end


(*
closeOut (outfilebar)
*)

fun put outf 0 =
	output(outf,"\n")
	| put outf n = 
	(output(outf,"X");put outf (n-1));
