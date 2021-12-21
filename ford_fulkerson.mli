open Graph

(* A path is a list of nodes. *)
type path = id list

type residual = int graph

type graph_flow = (int * int) graph

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val not_already_vis : (id * int) list-> id list -> (id * int) list

val find_path: residual -> id -> id -> path 

val find_mini_flow: residual -> path -> int

val update_path_less : residual -> int -> path -> residual

val update_path_more : residual -> int -> path -> residual

val del_arc_null: residual -> residual

val update_path : residual -> int -> path -> residual

val init_graph_flow : residual -> graph_flow

val update_arc_gf : graph_flow -> id -> id -> int -> graph_flow

val update_graph_flow : graph_flow -> int -> path -> graph_flow

val string_gf : graph_flow -> string graph

val ford_fulkerson_algo : residual -> id -> id -> string graph



