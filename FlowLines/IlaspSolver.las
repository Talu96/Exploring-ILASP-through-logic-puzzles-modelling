cell((1..4,1..4)).
path(1..4).

% 1{cell_in_path(C, P): path(P)}1 :- cell(C).

% % for each path it must exist one start and one end
% 1{start(C, P): cell(C)}1 :- path(P).
% 1{end(C, P): cell(C)}1 :- path(P).

% start and end of path P belongs to P
cell_in_path(C, P) :- start(C, P).
cell_in_path(C, P) :- end(C, P).

%adj definition
adj((X, Y1), (X, Y2)) :- cell((X, Y1)), cell((X, Y2)), |Y1 - Y2| == 1.
adj((X1, Y), (X2, Y)) :- cell((X1, Y)), cell((X2, Y)), |X1 - X2| == 1.

%every cell, except end/start, must have a next/prev cell that is adj to it
1{next(C, C1): adj(C, C1)}1 :- cell_in_path(C, P), not end(C, P).
1{prev(C, C1): adj(C, C1)}1 :- cell_in_path(C, P), not start(C, P).

%next of C2 is prev of it and viceversa
prev(C2, C1) :- next(C1, C2).
next(C2, C1) :- prev(C1, C2).

%definition of reachability of start from C (in the same path)
path_to_start(C):- start(C, P).
path_to_start(C):- next(S, C), start(S, P), cell_in_path(C, P).
path_to_start(C):- prev(C, S), start(S, P), cell_in_path(C, P).
path_to_start(C):- prev(C, C1), cell_in_path(C, P), cell_in_path(C1, P), path_to_start(C1).

%additional definition
same_path(C1, C2) :- cell_in_path(C1, P), cell_in_path(C2, P).
same_path(C2, C1) :- same_path(C1,C2).
crossing(P1, P2) :- cell_in_path(C, P1), cell_in_path(C, P2), P1!=P2.
crossing(P2, P1) :- crossing(P1,P2).

%what cannot happen
not_good(P) :- crossing(P, P1), P!=P1, path(P), path(P1).
not_good(P) :- start(C1, P), start(C2, P), C1!=C2, path(P).
not_good(P) :- end(C1, P), end(C2, P), C1!=C2, path(P).

%% each path has only one start   
#pos({start((1,2),1), cell_in_path((1,2),1)},{start((2,3),1)}).
#pos({start((3,1),1)},{start((3,1),2),start((3,1),3),start((3,1),4)}).
#pos({cell_in_path((3,1),1)},{cell_in_path((3,1),2), cell_in_path((3,1),3), cell_in_path((3,1),4)}).

%% start and end cannot be coincident
#neg({start((1,1),1), end((1,1),1)},{}).

%% next and previous of a cell cannot be the same
#pos({next((2,2),(3,2))},{prev((2,2),(3,2))}).
#neg({next((2,2),(3,2)), prev((2,2),(3,2))},{}).

%% previous and next must be in the same path
#pos({prev((2,1),(3,1)), cell_in_path((2,1),3)},{cell_in_path((3,1),4)}).
#pos({next((2,1),(3,1)), cell_in_path((2,1),3)},{cell_in_path((3,1),4)}).
#neg({next((2,2),(3,2)), cell_in_path((2,2),1), cell_in_path((3,2),4)},{}).

%% every cell of a path must be reachable from start   
#neg({cell_in_path((2,1),1), cell_in_path((2,2),1), cell_in_path((1,2),1), cell_in_path((1,1),2), start((3,2),2)},{}).
#neg({cell_in_path((1,2),1), cell_in_path((1,3),1), cell_in_path((1,4),1), cell_in_path((2,2),1), cell_in_path((2,4),1),
    cell_in_path((3,2),1), cell_in_path((3,3),1), cell_in_path((3,4),1), cell_in_path((2,3),2), start((1,1),2)},{}).

%% every start of a path P must belong to path P
#neg({start((3,1),2),cell_in_path((3,1),1)},{}).

#neg({next((1,1),(3,4)), next((1,4),(3,4)), next((2,1),(3,4)), next((2,4),(3,4)), next((3,3),(3,4)), 
      next((4,2),(3,4)), next((1,2),(3,4)), next((2,2),(3,4)), next((3,1),(3,4)), next((3,4),(3,4)), 
      next((4,3),(3,4)), next((1,3),(3,4)), next((2,3),(3,4)), next((3,2),(3,4)), next((4,1),(3,4)), next((4,4),(3,4))},{}).

%% previous of a cell cannot be the previous of another cell
#neg({prev((3,1),(1,1)), prev((2,1),(1,1))},{}).


1 ~ :- not_good(P).
1 ~ :- crossing(P1, P2).

2 ~ :- end(C, P), start(C, P).                  
2 ~ :- next(C, C1), prev(C, C1).                
2 ~ :- cell(C), not path_to_start(C).       
2 ~ cell_in_path(C, P) :- start(C, P).

3 ~ 1{start(C, P): cell(C)}1 :- path(P).
3 ~ 1{end(C, P): cell(C)}1 :- path(P).

3 ~ :- next(C1, C), next(C2, C), C1!=C2.
3 ~ :- prev(C1, C), prev(C2, C), C1!=C2.
3 ~ :- cell_in_path(C, P1), cell_in_path(C, P2), P1!=P2.

4 ~ :- cell_in_path(C1, P1), cell_in_path(C2, P2), P1!=P2, next(C1, C2).        


% #modeha(start(var(cell),var(path))).
% #modeh(start(var(cell),var(path))).
% #modeb(1, start(var(cell),var(path))).
% #modeha(end(var(cell),var(path))).
% #modeh(end(var(cell),var(path))).
% #modeb(1, end(var(cell),var(path))).
% #modeb(2, not_good(var(path),var(path))).
% #modeb(1, same_path(var(cell),var(cell))).
% #modeb(1, crossing(var(path),var(path))).
% #modeb(1, next(var(cell),var(path))).
% #modeb(1, prev(var(cell),var(path))).

#maxv(3).
#minhl(1).
#maxhl(5).