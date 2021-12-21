open Graph
open Tools

(* A path is a list of nodes. *)
type path = id list

type residual = int graph

(*graph of flow with two values of the arcs (first : the flow which pass this arc; second : the rate of flow of the arc) *)
type graph_flow = (int * int) graph


let not_already_vis l_arcs forbidden = List.filter (fun (x,a) -> not (List.mem x forbidden)&& a!=0) l_arcs
    

(*Find a possible path between two nodes*)
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
            in 
        let res = List.rev(loop_path [] id1) in 
    if res !=[] then (id1::res) else [] 
    
   
(*Calculate the minimal flow of a path*)
let find_mini_flow gr = function 
    | [] -> assert false
    | (a::path) ->
    let rec loop_mini aux id = function
        | [] -> aux
        | a::rest -> match (find_arc gr id a) with 
                    | None -> failwith "erreur de chemin" 
                    | Some x ->  if x < aux then loop_mini x a rest else loop_mini aux a rest 
    in 
    loop_mini max_int a path 


let update_path_less gr mini_flow = function
    | [] -> assert false 
    | (a::path) -> 
    let rec loop_mini gr2 id = function 
        | [] -> gr2
        | a::rest -> loop_mini (add_arc gr2 id a (-mini_flow)) a rest 
    in loop_mini gr a path


let update_path_more gr mini_flow = function
    | [] -> assert false 
    | (a::path) ->  
    let rec loop_mini gr2 id = function 
        | [] -> gr2
        | a::rest -> loop_mini (add_arc gr2 a id mini_flow) a rest
    in loop_mini gr a path

(*Delete arc with value 0*)
let del_arc_null gr = e_fold gr (fun gr id1 id2 lbl -> if lbl !=0 then new_arc gr id1 id2 lbl else gr) (clone_nodes gr)

(*function which gives a residual graph with a path and the flow minimal of this path*)
let update_path gr mini_flow path =
    let gr2 = update_path_less gr mini_flow path in  
        let path_more = update_path_more gr2 mini_flow path in 
        del_arc_null path_more

(*Intialisation of the a the graph of flow with a basic graph*)
let init_graph_flow gr = gmap gr (fun x -> (0,x) )

(*Update the arc of the graph of flow *)
let update_arc_gf gr id1 id2 n = match (find_arc gr id1 id2) with 
    | None -> (match (find_arc gr id2 id1) with 
        | None -> gr  
        | Some (x,y) -> new_arc gr id2 id1 (x-n,y))
    | Some (x,y) -> new_arc gr id1 id2 (n+x,y)

let update_graph_flow gr mini_flow = function
    | [] -> assert false 
    | (a::path) ->  
    let rec loop_mini gr2 id = function 
        | [] -> gr2
        | a::rest -> loop_mini (update_arc_gf gr2 id a mini_flow) a rest
    in loop_mini gr a path 

let string_gf gr = gmap gr (fun (x,y) -> string_of_int x^"/"^string_of_int y )

let ford_fulkerson_algo gr source target = 
    let gf = init_graph_flow gr in
    let rec loop_find gr2 gf2 max_flow path = match path with
        | [] -> (gf2,max_flow)
        | reste -> (let mini_flow = find_mini_flow gr2 path in
            let gr3 = update_path gr2 mini_flow path in 
                let gf3 = update_graph_flow gf2 mini_flow path in 
                loop_find gr3 gf3 (max_flow+mini_flow) (find_path gr3 source target) )

            in 
        let (g,max_flow) = loop_find gr gf 0 (find_path gr source target) in 
    let () = Printf.printf "The algorithm terminated with a maximum flow value of: %d\n%!" max_flow in 
    string_gf g

        


        



