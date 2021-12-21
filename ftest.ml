open Gfile
open Tools
open Ford_fulkerson
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  let gr = gmap graph (fun x -> (int_of_string x)) in

  let gr2 = ford_fulkerson_algo gr source sink in

  let () = export outfile gr2 in

  ()
    
  (*let path = find_path gr source sink in 

  let result = List.map string_of_int path in
  
  let result2 = String.concat ";" result in

  let () = Printf.printf "Chemin égal %s\n%!" result2 in

  let flow = find_mini_flow gr path in 

  let gr2 = update_path gr flow path in 
  
  let () = Printf.printf ("résultat flow_max : %d\n%!") flow_max in *) 

