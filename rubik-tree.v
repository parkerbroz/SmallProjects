From Coq Require Import Lists.List. Import ListNotations.
Require Import Coq.Lists.List Coq.Bool.Bool.
Import Coq.Lists.List.ListNotations.
Scheme Equality for list.

Inductive move :=
	| Up
	| Down
	| Left
	| Right
	| Front
	| Back
	| Up'
	| Down'
	| Left'
	| Right'
	| Front'
	| Back'.

(** We represent permutations of our cube as combinations of moves on 
the solved cube **)

Definition cube := list move.

Definition solved := @nil move.

(** We also admit representation as a matrix.
		the first list denotes (up, down, left, right, front, back) 
		the second list denootes the row from top to bottom 
		the third list denotes the column from left to right **)

Inductive color :=
	| Red
	| Blue
	| Green
	| Orange
	| Yellow
	| White.

Definition color_eqb (c1 c2 : color) : bool :=
  match c1, c2 with
  | Red, Red => true
  | Blue, Blue => true
  | Green, Green => true
  | Orange, Orange => true
  | Yellow, Yellow => true
  | White, White => true
  | _, _ => false
end.

Inductive face : Type :=
  | face_cons : color -> color -> color -> color -> face.

Inductive cube' : Type :=
  | cube_cons : face -> face -> face -> face -> face -> face -> cube'.

Definition solved' : cube' :=
  cube_cons (face_cons White White White White)
            (face_cons Yellow Yellow Yellow Yellow)
            (face_cons Green Green Green Green)
            (face_cons Blue Blue Blue Blue)
            (face_cons Red Red Red Red)
            (face_cons Orange Orange Orange Orange).

Definition sim_Up (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons ub1 ua1 ub2 ua2)
              (face_cons da1 da2 db1 db2)
              (face_cons fa1 fa2 lb1 lb2)
              (face_cons ba1 ba2 rb1 rb2)
              (face_cons ra1 ra2 fb1 fb2)
              (face_cons la1 la2 bb1 bb2)
end.

Definition sim_Down (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons db1 da1 db2 da2)
              (face_cons la1 la2 bb1 bb2)
              (face_cons ra1 ra2 fb1 fb2)
              (face_cons fa1 fa2 lb1 lb2)
              (face_cons ba1 ba2 rb1 rb2)
end.

Definition sim_Left (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons bb2 ua2 ba2 ub2)
              (face_cons fa1 da2 fb1 db2)
              (face_cons lb1 la1 lb2 la2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons ua1 fa2 ub1 fb2)
              (face_cons ba1 db1 bb1 da1)
end.

Definition sim_Right (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons ua1 fa2 ub1 fb2)
              (face_cons da1 bb1 db1 ba1)
              (face_cons la1 la2 lb1 lb2)
              (face_cons rb1 ra1 rb2 ra2)
              (face_cons fa1 da2 fb1 db2)
              (face_cons ub2 ba2 ua2 bb2)
end.

Definition sim_Front (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons ua1 ua2 lb2 la2)
              (face_cons rb1 ra1 db1 db2)
              (face_cons la1 da1 lb1 da2)
              (face_cons ub1 ra2 ub2 rb2)
              (face_cons fb1 fa1 fb2 fa2)
              (face_cons ba1 ba2 bb1 bb2)
end.

Definition sim_Back (c : cube') : cube' :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    cube_cons (face_cons ra2 rb2 ub1 ub2)
              (face_cons da1 da2 la1 lb1)
              (face_cons ua2 la2 ua1 lb2)
              (face_cons ra1 db2 rb1 db1)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons bb1 ba1 bb2 ba2)
end.

(** checked the following for sanity with a real-life cube **)
Compute sim_Up solved'.
Compute sim_Down solved'.
Compute sim_Left solved'.
Compute sim_Right solved'.
Compute sim_Front solved'.
Compute sim_Back solved'.

Definition sim_move (m : move) (c : cube') :=
	match m with
	| Up => sim_Up c
	| Down => sim_Down c
	| Left => sim_Left c
	| Right => sim_Right c
	| Front => sim_Front c
	| Back => sim_Back c
	| Up' => sim_Up (sim_Up (sim_Up c))
	| Down' => sim_Down (sim_Down (sim_Down c))
	| Left' => sim_Left (sim_Left (sim_Left c))
	| Right' => sim_Right (sim_Right (sim_Right c))
	| Front' => sim_Front (sim_Front (sim_Front c))
	| Back' => sim_Back (sim_Back (sim_Back c))
end.

Fixpoint cube_to_cube' (c : cube) (start : cube') : cube' :=
	match c with
	| [] => start
  | (m::ms) => sim_move m (cube_to_cube' ms start)
end.

Definition flatten_cube' (c : cube') : list color :=
  match c with
  | cube_cons (face_cons ua1 ua2 ub1 ub2)
              (face_cons da1 da2 db1 db2)
              (face_cons la1 la2 lb1 lb2)
              (face_cons ra1 ra2 rb1 rb2)
              (face_cons fa1 fa2 fb1 fb2)
              (face_cons ba1 ba2 bb1 bb2) =>
    [ua1; ua2; ub1; ub2; da1; da2; db1; db2; la1; la2; lb1; lb2; ra1; ra2; rb1; rb2; fa1; fa2; fb1; fb2; ba1; ba2; bb1; bb2]
end.

Fixpoint flat_cube'_eq (r1 : list color) (r2 : list color) : bool :=
  match (r1,r2) with
  | (Red::t1,Red::t2) => flat_cube'_eq t1 t2
	| (Blue::t1,Blue::t2) => flat_cube'_eq t1 t2
	| (Green::t1,Green::t2) => flat_cube'_eq t1 t2
	| (Orange::t1,Orange::t2) => flat_cube'_eq t1 t2
	| (White::t1,White::t2) => flat_cube'_eq t1 t2
	| (Yellow::t1,Yellow::t2) => flat_cube'_eq t1 t2
  | ([],[]) => true
  | _ => false
end.

(** Now, we want to show that:
  if a given cube c can be obtained from the solved cube in n moves, 
  then we can invert those n moves to solve c. **)

Definition invert_move (m : move) : move :=
  match m with
  | Up => Up'
  | Down => Down'
  | Left => Left'
  | Right => Right'
  | Front => Front'
  | Back => Back'
  | Up' => Up
  | Down' => Down
  | Left' => Left
  | Right' => Right
  | Front' => Front
  | Back' => Back
end.

(** for now, assuming our implementation is correct **)
Lemma repetition_identity :
  forall (m : move) (c' : cube'),
  cube_to_cube' [m;m;m;m] c' = c'.
Proof.
  intros m c'.
  unfold cube_to_cube'.
  destruct m; destruct c'; 
  destruct f, f0, f1, f2, f3, f4; 
  try reflexivity.
Qed.

Lemma inversion_identity :
  forall (m : move) (c : cube), 
  cube_to_cube' (invert_move m::m::c) solved' = cube_to_cube' c solved'.
Proof.
  intros. induction c.
  + simpl. induction m; reflexivity.
  + destruct m eqn:em;
    pose proof repetition_identity as H1;
    specialize H1 with (m := m) (c' := sim_move a (cube_to_cube' c solved'));
    rewrite em in H1; try apply H1;
    pose proof repetition_identity as H2;
    specialize H2 with (m := invert_move m) (c' := sim_move a (cube_to_cube' c solved'));
    rewrite em in H2; try apply H2. 
Qed.

Fixpoint invert_cube (c : cube) : cube :=
  match c with
  | [] => []
  | (m::ms) => invert_cube ms ++ [invert_move m]
end.


Lemma cube_to_cube'_list_linear :
  forall (c1 : cube) (c2 : cube),
  cube_to_cube' (c1 ++ c2) solved' = 
  cube_to_cube' c1 (cube_to_cube' c2 solved').
Proof.
  intros. induction c1.
  - simpl. reflexivity.
  - simpl. rewrite IHc1. reflexivity. 
Qed.

Lemma inversion_solves :
  forall (c : cube),
  cube_to_cube' (invert_cube c) (cube_to_cube' c solved') = solved'.
Proof.
  intros. induction c as [| m ms IH].
  - reflexivity.
  - rewrite <- cube_to_cube'_list_linear. simpl. 
    rewrite <- app_assoc. simpl.
    rewrite cube_to_cube'_list_linear.
    rewrite inversion_identity.
    apply IH.
Qed.

(** Now the furthest a cube can be from solved is:
  max (min (# moves to generate a given cube))

To find this, we take inspiration from the following algorithm:
  S_new = {solved'}
  S_old = {}
  i = 0
  while |S_new| > 0 :
    S_old = S_old \union S_new
    for each s in S_old:
      for each move:
        add (cube_to_cube' move s) to S_new
    i = i + 1
  return i

The loop will terminate when:
        S_new is empty
  <==>  forall (s in S_old) (m : move), (cube_to_cube' m s) in S_old
  <==>  S_old is closed under our given moves
  <==>  we have generated all possible cubes starting from solved'
        under our permitted moves

Therefore i will denote the most moves we can make
while still generating a new cube, which is also the
furthest any cube can be from solved' by inversion_solves. **)

Inductive color_tree : Type :=
  | ColorNode : list (list color) -> list (color * color_tree) -> color_tree.

Fixpoint generate_tree (depth : nat) (colors : list color) : color_tree :=
  match depth with
  | 0 => ColorNode [] []
  | S n => ColorNode [] (map (fun color => (color, generate_tree n colors)) colors)
end.

Fixpoint add_colors_to_tree (t : color_tree) (c : list color) : color_tree :=
  match t with
  | ColorNode cubes children =>
    match c with
    | [] => t
    | c_head::c_rest =>
      match find (fun pair => color_eqb (fst pair) c_head) children with
      | Some (_, child) =>  
        let new_child := add_colors_to_tree child c_rest in
        let new_children := map (fun pair => if color_eqb (fst pair) c_head then (c_head, new_child) else pair) children in
        ColorNode cubes new_children
      | None => ColorNode (c::cubes) children
    end
  end
end.

Fixpoint isin (S_all : list (list color)) (c' : list color) : bool :=
  match S_all with
  | (c::S_rest) => if flat_cube'_eq c c' then true else isin S_rest c'
  | [] => false
end.

Fixpoint in_tree (t : color_tree) (c : list color) : bool :=
  match t with
  | ColorNode cubes children =>
    match children with
    | [] => isin cubes c
    | _ => 
    match c with
      | [] => false
      | c_head::c_rest =>
        match find (fun pair => color_eqb (fst pair) c_head) children with
        | Some (_, child) => in_tree child c_rest
        | None => false
      end
    end
  end
end.

Fixpoint in_tree_any (t : color_tree) (c's : list cube') : bool :=
  match c's with
  | (c'::c'_rest) => if in_tree t (flatten_cube' c') then true else in_tree_any t c'_rest
  | [] => false
end.

Definition all_orients (c : cube') : list cube' :=
  match c with
  | c => 
  [c; cube_to_cube' [Up; Down'] c; cube_to_cube' [Up; Down'; Up; Down'] c; cube_to_cube' [Up'; Down] c;
  cube_to_cube' [Left; Right'] c; cube_to_cube' [Left; Right'; Up; Down'] c; cube_to_cube' [Left; Right'; Up; Down'; Up; Down'] c; cube_to_cube' [Left; Right'; Up'; Down] c;
  cube_to_cube' [Left; Right'; Left; Right'] c; cube_to_cube' [Left; Right'; Left; Right'; Up; Down'] c; cube_to_cube' [Left; Right'; Left; Right'; Up; Down'; Up; Down'] c; cube_to_cube' [Left; Right'; Left; Right'; Up'; Down] c;
  cube_to_cube' [Left'; Right] c; cube_to_cube' [Left'; Right; Up; Down'] c; cube_to_cube' [Left'; Right; Up; Down'; Up; Down'] c; cube_to_cube' [Left'; Right; Up'; Down] c;
  cube_to_cube' [Front'; Back] c; cube_to_cube' [Front'; Back; Up; Down'] c; cube_to_cube' [Front'; Back; Up; Down'; Up; Down'] c; cube_to_cube' [Front'; Back; Up'; Down] c;
  cube_to_cube' [Front; Back'] c; cube_to_cube' [Front; Back'; Up; Down'] c; cube_to_cube' [Front; Back'; Up; Down'; Up; Down'] c; cube_to_cube' [Front; Back'; Up'; Down] c]
end.

(** We leave out: Down, Down', Right, Right', Back, Back'
for efficiency since they are the same as the other 6 moves
up to orientation. **)

Definition moves := [Up; Up'; Left; Left'; Front; Front'].

Fixpoint permute_helper (t : color_tree) (c' : cube') (ms : list move) :=
  match ms with
  | (m::ms) => let c'' := (cube_to_cube' [m] c') in
                if (in_tree_any t (all_orients c''))
                then permute_helper t c' ms
                else let fut := permute_helper (add_colors_to_tree t (flatten_cube' c'')) c' ms
                  in ((c'' :: (fst fut)), (snd fut)) 
  | [] => ([],t)
end.

Fixpoint permute (S_all : list cube') (S_rest : list cube') (t : color_tree) :=
  match S_rest with
  | (c'::S_rest) => let x := permute_helper t c' moves in
    let fut := permute ((fst x) ++ S_all) S_rest (snd x) in
    ((fst x) ++ (fst fut), snd fut)         
  | [] => ([],t)
end.

Fixpoint perm_n (n : nat) (S_all : list cube') (t : color_tree) :=
  match n with
  | 0 => [length (S_all)]
  | S x => let y := permute S_all S_all t in
    [length (S_all)] ++ perm_n x (fst y) (snd y)
end.

Definition init_tree := (add_colors_to_tree (generate_tree 9 [Red;Orange;Yellow;Green;Blue;White]) (flatten_cube' solved')).


(** Unsurprisingly, getting all of our permutations takes quite some time. 
The first computation below can be used as a sanity check with the table
from https://www.jaapsch.net/puzzles/cube2.htm.

The i-th element of (perm_n n [solved'] init_tree) is the number of cubes
which are reachable in exactly i moves and cannot be reached in fewer. 

This list should correspond to the total column in the linked table.
Note this total is the amount of cubes reachable in exactly n moves,
so each entry in our list is equal to the sum of the total column up to n. **)

Compute perm_n 7 [solved'] init_tree.

(** I'm not sure why, but because of some Coq weirdness, the real proof
takes a long time to run. If you like, you can instead run this computation
to see the result for yourself. (takes around 30 minutes) **)

Compute perm_n 15 [solved'] init_tree.

(** **)
(** the proof **)
Definition permutations := Eval compute in perm_n 15 [solved'] init_tree.

Theorem God's_Number_14 :
   hd 0 (rev permutations) = 0 /\ (len permutations) = 15.
Proof.
  unfold permutations.
  reflexivity.
Qed.