(*
- ();
val it = () : unit
- (1);
val it = 1 : int
- (1,2);
val it = (1,2) : int * int
- [];
val it = [] : 'a list
- [1];
val it = [1] : int list
- [1,2];
val it = [1,2] : int list
*)

explode "123";
implode  [#"1",#"2",#"3"] ;

(implode o explode) "123";

[#"1",#"2",#"3"] @ [#"1",#"2",#"3"];
[1,2,3]@[1,2,3];

 concat;
(*
val it = fn : string list -> string
*)

#2(1,2,3)