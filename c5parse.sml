open TextIO;
exception Syntax;

fun digit(c) = 
	(#"0"<=c andalso c <= #"9");

fun integer(IN) = 
let
	fun integer1(IN,i) = 
	case lookahead(IN) of
		SOME c => 
			if digit(c) then 
				(input1(IN);integer1(IN,10*i+ord(c) - ord(#"0")))
			else i
		| NONE => i
in
	integer1(IN,0)
end

fun atom(IN) =
	case lookahead(IN) of
		SOME #"(" =>(
			input1(IN);
			let val e = expression(IN) in
				if lookahead(IN) = (SOME #")") then
					(input1(IN);e)
				else
					raise Syntax
			end
		)
		| SOME c =>
			if digit(c) then integer(IN)
			else raise Syntax
		| NONE => raise Syntax
and
term IN = 
let
	fun termTail (IN,i) = 
		case lookahead(IN) of
			  SOME #"*" =>(
				input1(IN);
				termTail(IN,i*atom(IN))
			)
			| SOME #"/" =>(
				input1(IN);
				termTail(IN,i div atom(IN))
			)
			| _ => i;		 
in		
	termTail(IN,atom(IN))
end
and
expression IN = 
let
	fun expTail (IN,i) = 
		case lookahead(IN) of
			SOME #"+" => (
				input1 IN;
				expTail(IN,i+term(IN))
			)
			| SOME #"-" =>(
				input1(IN);
				expTail(IN,i-term(IN))
			)
			| _ => i;			
in
	expTail(IN,term(IN))
end

(*
	this can be used as a calculator
	1+1
	1*(2+3) 
	((1+2))
	etc

	expression(stdIn)
*)