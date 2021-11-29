open Graph

(* A path is a list of nodes. *)
type path = id list

type residual = int graph

let not_already_vis l_arcs forbidden = List.filter (fun (x,a) -> not (List.mem x forbidden)) l_arcs
    
let add_forbidden id forbidden = id::forbidden

let find_path gr id1 id2 = 

    let rec loop_path path id_current = 
        let aux = out_arcs gr id_current in
            let to_be_visit = not_already_vis aux path in 
                let rec loop_arc = function
                    | [] -> []
                    | (a,b)::rest -> if a=id2 then a::path 
                    else (match (loop_path (a::path) a) with
                            | [] -> loop_arc rest
                            | _ -> (a::path))

                in loop_arc to_be_visit                 
    in loop_path [] id1
    
   
        
