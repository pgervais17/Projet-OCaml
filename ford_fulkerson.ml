open Graph
open Tools

(* A path is a list of nodes. *)
type path = id list

type residual = int graph

let not_already_vis l_arcs forbidden = List.filter (fun (x,a) -> not (List.mem x forbidden)&& a!=0) l_arcs
    
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
                            | reste -> reste)

                in loop_arc to_be_visit                 
    in List.rev(loop_path [] id1)
    
   
   (*function qui calcul le flow minimal du chemin trouvé *)

let find_mini_flow gr (a::path) = 

    let rec loop_mini aux id = function
        | [] -> aux
        | a::rest -> match (find_arc gr id a) with 
                    | None -> raise "erreur de chemin" 
                    | Some x ->  if x< aux then loop_mini x a rest else loop_mini aux a rest 
    in 
    loop_mini max_int a path 

        
let update_path_less gr (a::path) mini_flow =   
    let rec loop_mini gr2 id = function 
        | [] -> gr2
        | a::rest -> loop_mini (add_arc gr2 id a (-mini_flow)) a rest
    in loop_mini gr a path


let update_path_more gr (a::path) mini_flow =   
    let rec loop_mini gr2 id = function 
        | [] -> gr2
        | a::rest -> loop_mini (add_arc gr2 a id mini_flow) a rest
    in loop_mini gr a path


let ford_fulkerson_algo gr source target = 
