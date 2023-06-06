# Exploring-ILASP-through-logic-puzzles-modelling
This repository contains the whole source code described in paper _**Exploring ILASP through logic puzzles modelling**_ that will be presented at _CILC 2023_ in Udine.
In each directory you will find two files _IlaspSolver.las_ and _AspSolver.lp_. We run ilasp version 2. 

## ILASP
ILASP (Inductive Learning of Answer Set Programs) is a logic-based machine learning system. It makes
use of existing knowledge base, containing anything known before the learning starts or even previously
learned rules, to infer new rules. We propose some examples on how ILASP works and how it can be used to
learn constraints. In order to do so we modelled different puzzles in Answer Set Programming: the main
focus concerns how different datasets can influence the learning algorithm and, consequently, what can
or cannot be learnt.

## Puzzles considered
### N-queens
N-queens is a well known puzzle in which we have a n x n board. The aim is to place n queens
such that they cannot attack each other; in other words, two queens cannot stay on the same
row, column or diagonal.

### Star Battle
Star Battle is a logic puzzle whose goal is to find a way to
put s·n stars on a n x n board (where s is the number
of allowed stars per row, column and field). The board
is divided in n fields of different size and shape and the
stars must be placed satisfying the following constraints:
two stars cannot be adjacent horizontally, vertically
or diagonally, and there must be s stars on each row,
column and field.

### Flow Lines
Flow Lines consists of a board where are placed some
pairs of dots. The goal is to connect the corresponding dots of every pair while filling the entire board.

### 15 Puzzle
15 puzzle is a sliding puzzle having 15 square tiles numbered from 1 to 15 in a
grid 4×4, leaving one unoccupied tile position. Note that
the puzzle is a planning problem because we are searching
a sequence of actions that could lead to the solution. In
fact, the aim is to move the tiles, using the empty space,
until they are ordered from 1 to 15 starting from the top
left corner. 
