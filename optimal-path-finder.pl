%File: PaulP&ChrisK_everest_phase1.pl
%Author: Paul Prae and Chris K.
%Last Edited: October 27th, 2011
%Purpose: In The Everest Attempt you must climb to the peak 
%	of an imaginary mountain and safely return to the base camp.
%	Here we will have Prolog find the optimal path there and back.
%For: Dr. Potter and CSCI 4540 Fall 2011 

%Enter 'go' to begin
go :-
	nl, nl,
	write('Welcome to The Everest Attempt: Phase 1!'),
	nl,
	write('----------------------------------------'),
	nl, nl,
	write('Using the default ''Example of a "Mountain"'''),
	nl,
	write('Prolog will find the optimal path from ''B'''),
	nl,
	write('to ''S'' and then back.'),
	nl, nl,
	write('''X'' will indicate the route planned, ''*'' will indicate'),
	nl,
	write('crevices, and ''_'' will indicate passable locations.'),
	nl, nl,
	write('The first optimal path to the summit is as follows:'),
	nl, nl,
	phase1(RouteThere,RouteBack),
	draw_board(12, -1, RouteThere),
	nl,
	write('The first optimal path back to the base camp is as follows:'),
	nl, nl,
	draw_board(12, -1, RouteBack),
	nl, nl,
	write('Thank you for watching! That is all we have for now.'),
	nl,
	write('Goodbye.'), !.
	
go.

:- dynamic boundary/2.

% Find optimal path for phase1 of assignment
% phase1(-RouteThere,-RouteBack)

phase1(RouteThere,RouteBack) :-
	crevices(Crevices),
	trip(12,4,1,10,10,Crevices,RouteThere,RouteBack).

% crevices for default board
crevices([	[2,1],
		[3,1],
		[5,1],
		[5,3],	
		[8,3],
		[11,4],
		[12,4],
		[11,5],
		[12,5],
		[12,6],
		[11,6],
		[7,6],
		[12,7],
		[11,7],
		[10,7],
		[8,7],
		[2,7],
		[9,8],
		[3,8],
		[2,9],
		[6,9],
		[12,9],
		[9,10],
		[8,10],
		[5,10],
		[4,11],
		[12,12],
		[4,12],
		[3,12]	]).

% north(+X,+Y,-NewX,-NewY)

north(X,Y,NewX,Y) :-
	NewX is X + 1,
	\+ boundary(NewX,Y).

% east(+X,+Y,-NewX,-NewY)

east(X,Y,X,NewY) :-
	NewY is Y + 1,
	\+ boundary(X,NewY).

% south(+X,+Y,-NewX,-NewY)
south(X,Y,NewX,Y) :-
	NewX is X - 1,
	\+ boundary(NewX,Y).

% west(+X,+Y,-NewX,-NewY)

west(X,Y,X,NewY) :-
	NewY is Y - 1,
	\+ boundary(X,NewY).


% tmove(+X,+Y,-NewX,-NewY)
% heading north

tmove(X,Y,NewX,NewY) :-
	north(X,Y,X2,Y2),
	north(X2,Y2,X3,Y3),
	tmove_north_x(X3,Y3,NewX,NewY).

% heading east
tmove(X,Y,NewX,NewY) :-
	east(X,Y,X2,Y2),
	east(X2,Y2,X3,Y3),
	tmove_east_x(X3,Y3,NewX,NewY).


% heading south
tmove(X,Y,NewX,NewY) :-
	south(X,Y,X2,Y2),
	south(X2,Y2,X3,Y3),
	tmove_south_x(X3,Y3,NewX,NewY).

% heading west
tmove(X,Y,NewX,NewY) :-
	west(X,Y,X2,Y2),
	west(X2,Y2,X3,Y3),
	tmove_west_x(X3,Y3,NewX,NewY).

% auxillary tmove predicates all of form: (+X,+Y,-NewX,-NewY)
tmove_north_x(X,Y,NewX,NewY) :-
	east(X,Y,NewX,NewY).

tmove_north_x(X,Y,NewX,NewY) :-
	north(X,Y,NewX,NewY).

tmove_north_x(X,Y,NewX,NewY) :-
	west(X,Y,NewX,NewY).

tmove_east_x(X,Y,NewX,NewY) :-
	north(X,Y,NewX,NewY).

tmove_east_x(X,Y,NewX,NewY) :-
	east(X,Y,NewX,NewY).

tmove_east_x(X,Y,NewX,NewY) :-
	south(X,Y,NewX,NewY).

tmove_south_x(X,Y,NewX,NewY) :-
	east(X,Y,NewX,NewY).

tmove_south_x(X,Y,NewX,NewY) :-
	south(X,Y,NewX,NewY).

tmove_south_x(X,Y,NewX,NewY) :-
	west(X,Y,NewX,NewY).

tmove_west_x(X,Y,NewX,NewY) :-
	north(X,Y,NewX,NewY).

tmove_west_x(X,Y,NewX,NewY) :-
	west(X,Y,NewX,NewY).

tmove_west_x(X,Y,NewX,NewY) :-
	south(X,Y,NewX,NewY).

% counter(+InitialValue,-Counter)

counter(InitialValue,InitialValue).

counter(InitialValue,Counter) :-
	
	counter(InitialValue,K),
	
	Counter is K + 1.


% assert_boundaries(+ListOfObstacles)
% asserts all the crevices as boundary(X,Y) facts
% the list of crevices must be a list of pairs

assert_boundaries([[X,Y|[]]|Tail]) :-
	assert(boundary(X,Y)),
	assert_boundaries(Tail).

assert_boundaries([]).



% assert_border(+GridSize)
% asserts a border of around the grid of boundary facts





assert_border(GridSize) :-
	
	Limit is GridSize + 1,
	
	repeat,
	
	counter(0,N),
	
	assert(boundary(N,Limit)),
	
	assert(boundary(N,0)),
	
	assert(boundary(0,N)),
	
	assert(boundary(Limit,N)),
	
	N == Limit,

	!.

% trip(+GridSize,+StartX,+StartY,+GoalX,+GoalY,+Crevics,-RouteThere,-RouteBack)
% trip determines both the route from the base to the goal, and the goal to the base

trip(GridSize,StartX,StartY,GoalX,GoalY,Crevices,RouteThere,RouteBack) :-
	retractall(boundary(_,_)), % ensure a clean KB
	assert_boundaries(Crevices),
	
	assert_border(GridSize),
	
	route(StartX,StartY,GoalX,GoalY,RouteThere), % route to goal
	route(GoalX,GoalY,StartX,StartY,RouteBack).  % return route

% route(+StartX,+StartY,+GoalX,+GoalY,-Route)
% uses iterative deepening to find the optimum route from start to goal

route(StartX,StartY,GoalX,GoalY,Route) :-	
	counter(0,N), % start at depth 0 and increase...
	route_x(N,StartX,StartY,GoalX,GoalY,[[StartX,StartY]],Route). % search all routes at depth N

% route_x(+N,+StartX,+StartY,+GoalX,+GoalY,+Visited,-Route)
% N is used to keep track of depth for iterative deepening

route_x(0,StartX,StartY,GoalX,GoalY,Visited,Route) :-
	
	tmove(StartX,StartY,GoalX,GoalY),
	reverse([[GoalX,GoalY]|Visited],Route).

route_x(N,StartX,StartY,GoalX,GoalY,Visited,Route) :-
	
	N > 0,
	
	NewN is N - 1,
	tmove(StartX,StartY,MiddleX,MiddleY),
	route_x(NewN,MiddleX,MiddleY,GoalX,GoalY,[[MiddleX,MiddleY]|Visited],Route).


%UI

%Base case, stops when N columns are the same as desired grid size
%Draws the numbers for the columns at the bottom of the board
draw_board(N, N, _) :-
	nl,
	draw_col_num(N, -1),
	nl.
%Intitial case, draw the numbers for the columns
draw_board(N, -1, Route) :-
	draw_col_num(N, -1),
	draw_board(N, 0, Route).
%Recursive predicate that draws N rows and columns
%First time this is called N must be 0
draw_board(GridSize, X, Route) :-
	draw_row(GridSize, X, -1, Route),
	NextX is X + 1,
	draw_board(GridSize, NextX, Route).
	
	
%Draw row numbers to the right of the board less than 10
draw_row(Y, X, Y, _) :-
	NextX is Y - X,
	NextX =< 9,
	NextX > 0,
	write(' |  '), write(NextX), 
	nl.
%Draw row numbers to the right of the board greater than 9
draw_row(Y, X, Y, _) :-
	NextX is Y - X,
	NextX >= 10,
	write(' | '), write(NextX), 
	nl.
%Draw row numbers to the left of the board that are less than 10
draw_row(GridSize, X, -1, Route) :-
	NextX is GridSize - X,
	NextX =< 9,
	NextX > 0,
	write(NextX), write('  | '),
	draw_row(GridSize, X, 0, Route).
%Draw numbers numbers to the left of the board that are greater than 9
draw_row(GridSize, X, -1, Route) :-
	NextX is GridSize - X,
	NextX >= 10,
	write(NextX), write(' | '),
	draw_row(GridSize, X, 0, Route).
%Draw the non-visited and non-crevice spaces on the board
draw_row(GridSize, X, Y, Route) :-
	RealX is GridSize - X,
	RealX > 0,
	RealY is Y + 1,
	\+ boundary(RealX, RealY),
	\+ route_member([RealX, RealY], Route),
	NextY is Y + 1,
	NextY =< GridSize,
	write(' _ '),
	draw_row(GridSize, X, NextY, Route).
%Draw the crevices
draw_row(GridSize, X, Y, Route) :-
	RealX is GridSize - X,
	RealX > 0,
	RealY is Y + 1,
	\+ route_member([RealX, RealY], Route),
	boundary(RealX, RealY),
	NextY is Y + 1,
	NextY =< GridSize,
	write(' * '),
	draw_row(GridSize, X, NextY, Route).
%Draw the route
draw_row(GridSize, X, Y, Route) :-
	RealX is GridSize - X,
	RealX > 0,
	RealY is Y + 1,
	\+ boundary(RealX, RealY),
	route_member([RealX, RealY], Route),
	NextY is Y + 1,
	NextY =< GridSize,
	write(' X '),
	draw_row(GridSize, X, NextY, Route).

%Base case for the column number boundary drawer	
draw_col_num(N, N):-
	nl.
%Initializer for column number drawer
draw_col_num(N, -1) :-
	write('     '),
	draw_col_num(N, 0).
%Recursive column numberer for number less than 11
draw_col_num(N, Y) :-
	NextY is Y + 1,
	NextY =< 10,
	write(' '), write(NextY), write(' '),
	draw_col_num(N, NextY).
%Recursive column numberer for numbers greater than 10
draw_col_num(N, Y) :-
	NextY is Y + 1,
	NextY > 10,
	NextY =< N,
	write(NextY), write(' '),
	draw_col_num(N, NextY).

%Find out if a coordinate is the member of a route
route_member([_, _], []) :-
	fail.

route_member([X, Y], [[X, Y]|[]]).

route_member([X, Y], [FirstMove, NextMove|_]) :-
	move_member([X, Y], FirstMove, NextMove).
	
route_member([X, Y], [FirstMove, NextMove|TailRoute]) :-
	\+ move_member([X, Y], FirstMove, NextMove),
		route_member([X, Y], [NextMove|TailRoute]).

%See if a coordinate is the member of the path of a move
move_member([X, Y], FirstMove, NextMove) :-
	get_move_path(FirstMove, NextMove, MovePathList),
	member([X, Y], MovePathList).
	
%Create a list of all the coordinates in a path
get_move_path([FirstX, FirstY], [NextX, NextY], [[FirstX, FirstY], [X2, Y2], [X3, Y3], [NextX, NextY]]) :-
	move_path([FirstX, FirstY], [X2, Y2], [X3, Y3], [NextX, NextY]).
	
	
%Possible move paths
%NE
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 + 2,
	Y4 is Y1 - 1,
	X3 is X1 + 2,
	Y3 is Y1,
	X2 is X1 + 1,
	Y2 is Y1.
%NN
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 + 3,
	Y4 is Y1,
	X3 is X1 + 2,
	Y3 is Y1,
	X2 is X1 + 1,
	Y2 is Y1.
%NW
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 + 2,
	Y4 is Y1 + 1,
	X3 is X1 + 2,
	Y3 is Y1,
	X2 is X1 + 1,
	Y2 is Y1.
%EN
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 + 1,
	Y4 is Y1 + 2,
	X3 is X1,
	Y3 is Y1 + 2,
	X2 is X1,
	Y2 is Y1 + 1.
%EE
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1,
	Y4 is Y1 + 3,
	X3 is X1,
	Y3 is Y1 + 2,
	X2 is X1,
	Y2 is Y1 + 1.
%ES
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 - 1,
	Y4 is Y1 + 2,
	X3 is X1,
	Y3 is Y1 + 2,
	X2 is X1,
	Y2 is Y1 + 1.
%SE
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 - 2,
	Y4 is Y1 + 1,
	X3 is X1 - 2,
	Y3 is Y1,
	X2 is X1 - 1,
	Y2 is Y1.
%SS
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 - 3,
	Y4 is Y1,
	X3 is X1 - 2,
	Y3 is Y1,
	X2 is X1 - 1,
	Y2 is Y1.
%SW
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 - 2,
	Y4 is Y1 - 1,
	X3 is X1 - 2,
	Y3 is Y1,
	X2 is X1 - 1,
	Y2 is Y1.
%WS
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 - 1,
	Y4 is Y1 - 2,
	X3 is X1,
	Y3 is Y1 - 2,
	X2 is X1,
	Y2 is Y1 - 1.
%WW
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1,
	Y4 is Y1 - 3,
	X3 is X1,
	Y3 is Y1 - 2,
	X2 is X1,
	Y2 is Y1 - 1.
%WN
move_path([X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
	X4 is X1 + 1,
	Y4 is Y1 - 2,
	X3 is X1,
	Y3 is Y1 - 2,
	X2 is X1,
	Y2 is Y1 - 1.
