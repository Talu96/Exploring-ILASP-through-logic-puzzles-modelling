#const n = 4.

coord(1..n).
num(1..n*n).
step(1..2).


value(1,1,1,1).  value(1,2,1,2).  value(1,3,1,3).  value(1,4,1,4).
value(2,1,1,5).  value(2,2,1,6).  value(2,3,1,7).  value(2,4,1,8).
value(3,1,1,9).  value(3,2,1,10). value(3,3,1,11). value(3,4,1,16).
value(4,1,1,13). value(4,2,1,14). value(4,3,1,15).  value(4,4,1,12).


1{value(X, Y, S, N): coord(X), coord(Y)}1 :- step(S), num(N).
1{value(X, Y, S, N): num(N)}1 :- step(S), coord(X), coord(Y).

move(N, S) :- value(X1, Y1, S, N), value(X2, Y2, S, n*n), value(X1, Y1, S+1, n*n), value(X2, Y2, S+1, N), step(S), step(S+1), num(N), |X1-X2|+|Y1-Y2|!=0.

value(X, Y, S+1, N) :- not move(N, S), value(X, Y, S, N), step(S), step(S+1), num(N).

0{move(N, S): num(N)}1 :- step(S).

:- move(N, S), value(X1, Y1, S, N), value(X2, Y2, S, n*n), |X1-X2| + |Y1-Y2| != 1.
:- move(N, S), move(N, S+1), num(N), step(S), step(S+1).
move(M, S) :- move(N, S+1), num(M), step(S), step(S+1).


value(3,4,2,12).
value(4,4,2,16).
