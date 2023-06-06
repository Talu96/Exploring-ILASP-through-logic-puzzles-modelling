
coord(1..3).
card(1..9).
step(1..31).

adj_empty(N, S) :- value(X1, Y1, S, N), value(X2, Y2, S, n*n), |X1 - X2| + |Y1 - Y2| == 1,
                   N!=n*n, coord(X1), coord(X2), coord(Y1), coord(Y2), step(S), card(N).

% ad ogni passo posso fare massimo una mossa
value(X, Y, S+1, n*n) :- move(N, S), value(X, Y, S, N), card(N), coord(X), coord(Y), step(S), step(S+1).
value(X, Y, S+1, N) :- move(N, S), value(X, Y, S, n*n), card(N), coord(X), coord(Y), step(S), step(S+1).

% se tra due istanti successivi i valori di N e n*n si sono invertiti, allora ho fatto una mossa
move(N, S) :- value(X, Y, S, N), value(XE, YE, S, n*n),
              value(X, Y, S+1, n*n), value(XE, YE, S+1, N), N!=n*n, 
              coord(X), coord(Y), coord(XE), coord(YE), step(S), step(S+1), card(N).


% se non ho fatto una mossa, N rimane dove si trova
value(X, Y, S+1, N) :- not move(N, S), value(X, Y, S, N), N!=n*n,
                       coord(X), coord(Y), step(S), card(N), step(S+1).


not_ordered_row(X, S) :- value(X, Y, S, N), N != n * (X-1) + Y,
                         coord(X), coord(Y), step(S), card(N).


not_ordered(S) :- value(X, Y, S, N), N != n * (X-1) + Y,
                  coord(X), coord(Y), step(S), card(N).






%% reaching the solution
#pos({not_ordered(30)},{not_ordered(31)}).
#neg({not_ordered(31)},{}).

%% at each step only one move is permitted
#pos({move(4,1)},{move(5,1)}).
#neg({move(4,2), move(1,2)}, {}).

%% each number appears only one time per step
#neg({value(3,1,5,3), value(1,2,5,3)},{}).

%% if N was moved at time S then I will not move it again at S+1
#pos({move(3,5)},{move(3,6)}).
#neg({move(3,4), move(3,5)},{}).

%% effetti della mossa
% #pos({value(1,1,1,9), value(1,2,1,6), move(6,1), value(1,1,2,6), value(1,2,2,9)},{}).
#neg({value(1,1,3,4), move(4,3), value(1,1,4,4)},{}).
#neg({value(2,3,8,7), move(7,8), value(2,3,9,2)},{}).

% non posso avere lo stesso numero in stessi istanti su celle diverse
% #pos({
%    value(1,1,1,8)
% },{
%     value(1,2,1,8), value(1,3,1,8),
%     value(2,1,1,8), value(2,2,1,8), value(2,3,1,8),
%     value(3,1,1,8), value(3,2,1,8), value(3,3,1,8)
% }).

%% moving tiles not adj to the empty one is not permitted
#pos({move(5,1), adj_empty (5,1)},{}).
#pos({move(4,4), move(8,3), move(5,2), move(4,1)},
     {move(8,5), move(7,5), move(2,5), move(3,5),move(1,5)},
     {value(1,1,1,8). value(1,2,1,9). value(1,3,1,6).
      value(2,1,1,5). value(2,2,1,4). value(2,3,1,7).
      value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).}).
#pos({
    move(5,1)
},{
    move(8,1), move(6,1), move(1,1), move(2,1)
},{
    value(1,1,1,8). value(1,2,1,4). value(1,3,1,6).
    value(2,1,1,5). value(2,2,1,9). value(2,3,1,7).
    value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).
}).
#pos({
    move(5,1), adj_empty(5,1)
},{}).
#pos({
    move(4,1)
},{
    move(8,1), move(6,1), move(1,1), move(2,1)
},{
    value(1,1,1,8). value(1,2,1,4). value(1,3,1,6).
    value(2,1,1,5). value(2,2,1,9). value(2,3,1,7).
    value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).
}).
#pos({
    move(7,1)
},{
    move(8,1), move(6,1), move(1,1), move(2,1)
},{
    value(1,1,1,8). value(1,2,1,4). value(1,3,1,6).
    value(2,1,1,5). value(2,2,1,9). value(2,3,1,7).
    value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).
}).
#pos({
    move(3,1)
},{
    move(8,1), move(6,1), move(1,1), move(2,1)
},{
    value(1,1,1,8). value(1,2,1,4). value(1,3,1,6).
    value(2,1,1,5). value(2,2,1,9). value(2,3,1,7).
    value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).
}).

#neg({
    move(8,1), move(6,1), move(1,1), move(2,1)
},{},{
    value(1,1,1,8). value(1,2,1,4). value(1,3,1,6).
    value(2,1,1,5). value(2,2,1,9). value(2,3,1,7).
    value(3,1,1,2). value(3,2,1,3). value(3,3,1,1).
}).
#neg({
    move(1,1), adj_empty(2,1), adj_empty(4,1), adj_empty(8,1), adj_empty(6,1)
},{},{}).

#pos({
move(6,13), move(5,12), move(4,11), move(7,10), 
move(8,9), move(4,8), move(5,7), move(6,6), 
move(4,5), move(8,4), move(7,3), move(5,2), move(6,1)
},{
    not_ordered(14), not_ordered(17), not_ordered(20),not_ordered(23),not_ordered(26),not_ordered(29),
    not_ordered(15), not_ordered(18), not_ordered(21),not_ordered(24),not_ordered(27),not_ordered(30),
    not_ordered(16), not_ordered(19), not_ordered(22),not_ordered(25),not_ordered(28),not_ordered(31)
},{
value(1,1,1,1). value(1,2,1,2). value(1,3,1,3).
value(2,1,1,5). value(2,2,1,6). value(2,3,1,9).
value(3,1,1,7). value(3,2,1,8). value(3,3,1,4).
}).

#neg({
value(1,1,28,1), value(1,2,28,2), value(1,3,28,3),
value(2,1,28,4), value(2,2,28,5), value(2,3,28,6),
value(3,1,28,7), value(3,2,28,8), value(3,3,28,9),
not_ordered(30)
},{}).


1 ~ :- not move(9, S), step(S).

2 ~ :- value(X1, Y1, S, N), value(X2, Y2, S, N), X1!=X2.
2 ~ :- value(X1, Y1, S, N), value(X2, Y2, S, N), Y1!=Y2.

2 ~ 2{adj_empty(N, S): card(N)}4 :- step(S).

5 ~ 1{value(X, Y, S, N): card(N)}1 :- step(S), coord(X), coord(Y).
5 ~ 1{value(X, Y, S, N): coord(X), coord(Y)}1 :- card(N), step(S).

4 ~ :- move(N, S), move(N, S+1), step(S+1), step(S).
4 ~ :- move(N, S), not adj_empty(N, S), card(N), step(S).

4 ~ :- not not_ordered(S), not_ordered(S+1), step(S), step(S+1).
5 ~ :- not not_ordered(S), move(N, S+1), step(S), step(S+1), card(N).

5 ~ :- step(S), not not_ordered(S), move(N,S1), S1>S, step(S1), card(N).
5 ~ :- step(S), not not_ordered(S), move(N,S+1), step(S+1), card(N).

% se ho fatto una mossa al tempo S+1 allora ne avevo fatta anche una prima al tempo S
6 ~ 1{move(M, S-1): card(M), step(S-1)}1 :- move(N, S), S>1, card(N), step(S).
5 ~ :- move(N, S), move(M, S), M!=N, card(N), card(M), step(S).

% non posso muovere cose non vicine al vuoto
4 ~ :- move(N, S), not adj_empty(N, S), card(N), step(S).
4 ~ :- not_ordered_row(X, S), not not_ordered_row(X+1, S), coord(X), coord(X+1).

1 ~ :- not_ordered(31).
2 ~ 0{not_ordered(S): step(S)}30.

3 ~ 1{move(N,S): card(N), step(S)}30.

% #modeb(2, move(var(card),var(step))).
% #modeb(2, not_ordered(var(step))).
% #modeb(2, adj_empty(var(card), var(step))).
% #modeb(1, step(var(step))).
% #modeb(1, card(var(card))).

#maxv(3).







% #pos({},{},{
%     value(1,1,1,2). value(1,2,1,9). value(1,3,1,4).
%     value(2,1,1,7). value(2,2,1,8). value(2,3,1,5).
%     value(3,1,1,3). value(3,2,1,1). value(3,3,1,6).
% }).
% #pos({},{},{
%     value(1,1,1,9). value(1,2,1,4). value(1,3,1,8).
%     value(2,1,1,3). value(2,2,1,1). value(2,3,1,2).
%     value(3,1,1,6). value(3,2,1,5). value(3,3,1,7).
% }).
% #pos({},{},{
%     value(1,1,1,7). value(1,2,1,5). value(1,3,1,6).
%     value(2,1,1,8). value(2,2,1,9). value(2,3,1,2).
%     value(3,1,1,1). value(3,2,1,4). value(3,3,1,3).
% }).

% #pos({},{},{
%     value(1,1,1,6). value(1,2,1,9). value(1,3,1,7).
%     value(2,1,1,8). value(2,2,1,2). value(2,3,1,3).
%     value(3,1,1,5). value(3,2,1,4). value(3,3,1,1).
% }).
% #pos({},{},{
%     value(1,1,1,5). value(1,2,1,1). value(1,3,1,9).
%     value(2,1,1,4). value(2,2,1,7). value(2,3,1,8).
%     value(3,1,1,6). value(3,2,1,2). value(3,3,1,3).
% }).