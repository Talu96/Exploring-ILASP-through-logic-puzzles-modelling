#const n=4.

cell((1..n,1..n)).
path(1..n).

1{start(C, P): cell(C)}1 :- path(P).
1{end(C, P): cell(C)}1 :- path(P).

:- start(C, P), end(C, P).

cell_in_path(C, P) :- start(C, P).
cell_in_path(C, P) :- end(C, P).

adj((X, Y1), (X, Y2)) :- cell((X, Y1)), cell((X, Y2)), |Y1 - Y2| == 1.
adj((X1, Y), (X2, Y)) :- cell((X1, Y)), cell((X2, Y)), |X1 - X2| == 1.

1{next(C, C1): cell_in_path(C1, P), adj(C, C1)}1 :- cell_in_path(C, P), not end(C, P).
1{prev(C, C1): cell_in_path(C1, P), adj(C, C1)}1 :- cell_in_path(C, P), not start(C, P).

path_to_start(C):- start(C, P).
path_to_start(C):- next(S, C), start(S, P), cell_in_path(C, P).
path_to_start(C):- prev(C, S), start(S, P), cell_in_path(C, P).
path_to_start(C):- prev(C, C1), cell_in_path(C, P), cell_in_path(C1, P), path_to_start(C1).

%%ILASP learned rules
same_path(C1, C2) :- cell_in_path(C1, P), cell_in_path(C2, P).
crossing(P1, P2) :- cell_in_path(C, P1), cell_in_path(C, P2), P1!=P2.
not_good(P) :- crossing(P, P1), P!=P1, path(P), path(P1).
not_good(P) :- start(C1, P), start(C2, P), C1!=C2, path(P).
not_good(P) :- end(C1, P), end(C2, P), C1!=C2, path(P).

#show start/2.
#show end/2.