(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *) 


let clone_nodes (gr:'a graph) = n_fold gr (new_node) empty_graph


let gmap (gr:'a graph) f = e_fold gr (fun gr id1 id2 lbl -> new_arc gr id1 id2 (f lbl)) (clone_nodes gr)


let add_arc gr id1 id2 n = match (find_arc gr id1 id2) with 
    | None -> new_arc gr id1 id2 n
    | Some x -> new_arc gr id1 id2 (n+x)