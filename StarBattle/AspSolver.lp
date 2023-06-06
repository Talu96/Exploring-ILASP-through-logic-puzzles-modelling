#const n = 8.
#const s = 1.

cell((1..n,1..n)).
field(1..n).

adj((X, Y1), (X, Y2)) :- cell((X, Y1)), cell((X, Y2)), |Y1 - Y2| == 1.
adj((X1, Y), (X2, Y)) :- cell((X1, Y)), cell((X2, Y)), |X1 - X2| == 1.
adj(X, Y) :- adj(Y, X). % Maybe useful

same_col((X1, Y), (X2, Y)) :- X1!=X2, cell((X1, Y)), cell((X2, Y)).
same_row((X, Y1), (X, Y2)) :- Y1!=Y2, cell((X, Y1)), cell((X, Y2)).
same_field(C1, C2) :- cell(C1), cell(C2), field(F), cell_in_field(C1, F), cell_in_field(C2, F). 

neighbour((X1, Y1), (X2, Y2)) :- |X1-X2| + |Y1-Y2| = 2, X1!=X2, Y1!=Y2, cell((X1, Y1)), cell((X2, Y2)).
neighbour(C1, C2) :- adj(C1,C2).

n*s{star_in_cell(C):cell(C)}n*s.

s-1{star_in_cell(S2): same_col(S1, S2), S1!=S2}s-1 :- star_in_cell(S1). 
s-1{star_in_cell(S2): same_row(S1, S2), S1!=S2}s-1 :- star_in_cell(S1). 
s-1{star_in_cell(S2): same_field(S1, S2), S1!=S2}s-1 :- star_in_cell(S1). 


:- star_in_cell(V1), star_in_cell(V2), neighbour(V1,V2), V1!=V2.
#show star_in_cell/1.