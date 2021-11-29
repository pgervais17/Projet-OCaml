open Graph

(* A path is a list of nodes. *)
type path = id list

type residual = int graph

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val not_already_vis : (id * int) list-> id list -> (id * int) list

val add_forbidden: id -> id list -> id list

val find_path: residual -> id -> id -> path 