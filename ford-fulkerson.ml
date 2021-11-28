open Graph

(* A path is a list of nodes. *)
type path = id list

let not_already_vis l_arcs forbidden = List.filter (fun (x,a) -> not (List.mem x forbidden)) l_arcs
    
let add_forbidden id forbidden = id::forbidden

let find_path gr id1 id2 = 
    let rec loop_path path forbidden id_current = 
        let aux = out_arcs gr id1 in
            let to_be_visit = not_already_vis aux forbidden in 
                let rec loop_arc 
                match to_be_vist with
                    | [] -> loop forbidden (List.hd forbidden)
                    | (a,b)::rest -> add_forbidden a forbidden

    
    (*function 
         if id2 = id_current then acu else 
          if *)
        
