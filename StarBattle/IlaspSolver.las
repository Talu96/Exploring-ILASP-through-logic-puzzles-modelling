cell((1..4,1..4)).
field(1..4).

same_col((X1, Y), (X2, Y)) :- cell((X1, Y)); cell((X2, Y)).
same_row((X, Y1), (X, Y2)) :- cell((X, Y1)); cell((X, Y2)).
same_field(C1, C2) :- cell(C1); cell(C2); field(F); cell_in_field(C1, F); cell_in_field(C2, F). 
neighbour((X1, Y1), (X2, Y2)) :- |X1-X2| + |Y1-Y2| = 2; cell((X1, Y1)); cell((X2, Y2)).

1{cell_in_field(C1, F): field(F)}1 :- cell(C1).


incompatible(C1, C2) :- C1!=C2; same_row(C1, C2).
incompatible(C1, C2) :- C1!=C2; same_col(C1, C2).
incompatible(C1, C2) :- C1!=C2; same_field(C1, C2).
incompatible(C1, C2) :- C1!=C2; neighbour(C1, C2).

% positive examples

#pos({
  %%inc
  star_in_cell((1,4))
  },{
  %%exc
    star_in_cell((1,3)), 
    star_in_cell((2,4)), 
    star_in_cell((3,4)), 
    star_in_cell((4,4))
  },{
  %%ctx
    cell_in_field((1,1),1). cell_in_field((1,2),1). cell_in_field((1,3),2). cell_in_field((1,4),2). 
    cell_in_field((2,1),1). cell_in_field((2,2),1). cell_in_field((2,3),1). cell_in_field((2,4),2). 
    cell_in_field((3,1),1). cell_in_field((3,2),3). cell_in_field((3,3),3). cell_in_field((3,4),2). 
    cell_in_field((4,1),4). cell_in_field((4,2),4). cell_in_field((4,3),4). cell_in_field((4,4),2).
}).



#pos({
    %%inc
    star_in_cell((1, 2))
  }, {       
    %%exc
    star_in_cell((1, 1)),     
    star_in_cell((1, 3)),     
    star_in_cell((1, 4)),
    star_in_cell((2, 2)),     
    star_in_cell((2, 3)),     
    star_in_cell((2, 4))
  }, {
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 4). cell_in_field((3, 2), 4). cell_in_field((3, 3), 4). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 3). cell_in_field((4, 2), 3). cell_in_field((4, 3), 3). cell_in_field((4, 4), 2).
}).    

#neg({
    star_in_cell((1,2)),
    star_in_cell((2,3))
  }, {}, {
    %%ctx
    cell_in_field((1,1),1). cell_in_field((1,2),1). cell_in_field((1,3),2). cell_in_field((1,4),2).
    cell_in_field((2,1),1). cell_in_field((2,2),1). cell_in_field((2,3),1). cell_in_field((2,4),2). 
    cell_in_field((3,1),1). cell_in_field((3,2),3). cell_in_field((3,3),3). cell_in_field((3,4),2). 
    cell_in_field((4,1),4). cell_in_field((4,2),4). cell_in_field((4,3),4). cell_in_field((4,4),2).
}).

#neg({
    star_in_cell((2, 2)),
    star_in_cell((2, 3))
  },{}, {
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 1). cell_in_field((3, 2), 3). cell_in_field((3, 3), 3). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 4). cell_in_field((4, 2), 4). cell_in_field((4, 3), 4). cell_in_field((4, 4), 2).
}).


#neg({
    star_in_cell((3, 1)),
    star_in_cell((3, 4))
  },{}, {
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 1). cell_in_field((3, 2), 3). cell_in_field((3, 3), 3). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 4). cell_in_field((4, 2), 4). cell_in_field((4, 3), 4). cell_in_field((4, 4), 2).
}).


#neg({
    star_in_cell((1, 3)), 
    star_in_cell((2, 2)),
    star_in_cell((3, 1)),
    star_in_cell((4, 3))
},{}, {
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 4). cell_in_field((3, 2), 4). cell_in_field((3, 3), 4). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 3). cell_in_field((4, 2), 3). cell_in_field((4, 3), 3). cell_in_field((4, 4), 2).
}).


#neg({
    star_in_cell((1, 2)),            
    star_in_cell((1, 4))
},{},{
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 4). cell_in_field((3, 2), 4). cell_in_field((3, 3), 4). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 3). cell_in_field((4, 2), 3). cell_in_field((4, 3), 3). cell_in_field((4, 4), 2).
}).

#neg({
    star_in_cell((1, 3)), 
    star_in_cell((2, 2)),
    star_in_cell((3, 1)),
    star_in_cell((4, 3))
},{},{
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 4). cell_in_field((3, 2), 4). cell_in_field((3, 3), 4). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 3). cell_in_field((4, 2), 3). cell_in_field((4, 3), 3). cell_in_field((4, 4), 2).
}).

#neg({
    star_in_cell((1, 3)), 
    star_in_cell((2, 2)),
    star_in_cell((3, 1)),
    star_in_cell((4, 3))    
},{},{
    %%ctx
    cell_in_field((1, 1), 1). cell_in_field((1, 2), 1). cell_in_field((1, 3), 2). cell_in_field((1, 4), 2). 
    cell_in_field((2, 1), 1). cell_in_field((2, 2), 1). cell_in_field((2, 3), 1). cell_in_field((2, 4), 2). 
    cell_in_field((3, 1), 4). cell_in_field((3, 2), 4). cell_in_field((3, 3), 4). cell_in_field((3, 4), 2). 
    cell_in_field((4, 1), 3). cell_in_field((4, 2), 3). cell_in_field((4, 3), 3). cell_in_field((4, 4), 2).
}).


3 ~ 1{star_in_cell(C): cell_in_field(C, F)}1 :- field(F).


#modeha(star_in_cell(var(cell))).
#modeb(2, star_in_cell(var(cell))).
#modeb(1, incompatible(var(cell), var(cell)), (symmetric)).


% #modeb(1, same_col(var(cell), var(cell))).
% #modeb(1, same_row(var(cell), var(cell))).
% #modeb(1, same_field(var(cell), var(cell))).
% #modeb(1, neighbour(var(cell), var(cell))).
% #modeb(1, field(var(field))).
% #modeb(2, var(cell)!=var(cell)).





#minhl(0).
#maxhl(4).