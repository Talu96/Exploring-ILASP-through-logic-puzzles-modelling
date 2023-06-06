coord(1..4).

4{queen(X, Y): coord(X), coord(Y)}4.

same_col(X1, Y, X2, Y) :- queen(X1,Y), queen(X2,Y), X1 != X2.
same_row(X, Y1, X, Y2) :- queen(X,Y1), queen(X,Y2), Y1 != Y2.
same_diagonal(X1, Y1, X2, Y2) :- queen(X1,Y1), queen(X2,Y2), X1!=X2,|X1-X2| =|Y1-Y2|.

:- same_row(X1, Y1, X2, Y2).
:- same_col(X1, Y1, X2, Y2).
:- same_diagonal(X1, Y1, X2, Y2).

#show queen/2.