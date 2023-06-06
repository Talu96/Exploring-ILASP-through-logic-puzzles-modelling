same_col(X1, Y, X2, Y) :- queen(X1,Y), queen(X2,Y), X1 != X2.
same_row(X, Y1, X, Y2) :- queen(X,Y1), queen(X,Y2), Y1 != Y2.
same_diagonal(X1, Y1, X2, Y2) :- queen(X1,Y1), queen(X2,Y2), X1 != X2, Y1 != Y2, Y1 + X1 == Y2 + X2.
same_diagonal(X1, Y1, X2, Y2) :- queen(X1,Y1), queen(X2,Y2), X1 != X2, Y1 != Y2, Y1 - X1 == Y2 - X2.


% in ogni colonna ci sta max una regina
#pos({
    queen(1,3)
},{
    queen(2,3), queen(3,3), queen(4,3)
},{
    coord(1..4).
}).

% in ogni riga ci sta max una regina
#pos({
    queen(1,3)
},{
    queen(1,2), queen(1,4), queen(1,1)
},{
    coord(1..4).
}).

% in ogni diagonale ci sta max una regina
#pos({
    queen(2,4)
},{
    queen(3,3), queen(4,2), queen(1,3)
},{
    coord(1..4).
}).

% due regine non possono stare sulla stessa diagonale
#neg({
    queen(1,1), queen(4,4)
},{},{
    coord(1..4).
}).

% due regine non possono stare sulla stessa riga
#neg({
    queen(2,1), queen(2,4)
},{},{
    coord(1..4).
}).

% due regine non possono stare sulla stessa colonna
#neg({
    queen(4,3), queen(2,3)
},{},{
    coord(1..4).
}).


1 ~ :- same_row(X1, Y1, X2, Y2).
1 ~ :- same_col(X1, Y1, X2, Y2).
1 ~ :- same_diagonal(X1, Y1, X2, Y2).
3 ~ 1 { queen(X,Y) : coord(Y) } 1 :- coord(X).
3 ~ 1 { queen(X,Y) : coord(X) } 1 :- coord(Y).
3 ~ 4{ queen(X,Y): coord(X), coord(Y) }4.


#maxv(4).
% #minhl(1).
% #maxhl(2).