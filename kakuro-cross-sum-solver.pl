%File: Paul_Prae.kakuro.pl
%Author: Paul Prae
%Last Edited: October 6th, 2011
%Purpose: To solve a Kakuro puzzle in Prolog
%For: Dr. Potter and CSCI 4540 Fall 2011 

%Prolog will have to solve these variables on its own
%given the rules of the cross-sum/kakuro game.
%go is with hints
go :-

	write('Each solution and the last failure will be timed.'),
	nl,
	write('The user will be responsible for adding them up.'),
	nl,
	write('Statistics will be issued before the solution is printed.'),
	nl,
	write('Variables for the cells are printed to screen as n1 to n79.'),
	nl,
	write('They are assigned to cells by reading the variable''s cells on'),
	nl,
	write('the physical puzzle from left to right and top to bottom.'),
	nl,
	nl,
	write('Here it goes!'),

	solve( _2X2, _2X3, _2X6, _2X8, _2X10, _2X11, _3X3, _3X4, _3X6, _3X7, _3X8, _3X10, _3X11,
	_3X12, _4X2, _4X3, _4X4, _4X5, _4X8, _4X9, _4X11, _4X12, _5X4, _5X5, _5X6, _5X9,
	_5X10, _6X2, _6X3, _6X4, _6X5, _6X6, _6X8, _6X9, _6X10, _6X12, _7X2, _7X3, _7X11,
	_7X12, _8X2, _8X3, _8X4, _8X5, _8X6, _8X8, _8X9, _8X10, _8X11, _8X12, _9X5, _9X6,
	_9X8, _9X10, _10X2, _10X3, _10X4, _10X5, _10X6, _10X8, _10X9, _10X10, _10X11, _10X12,
	_11X2, _11X3, _11X4, _11X6, _11X7, _11X8, _11X10, _11X12, _12X2, _12X3, _12X6, _12X7,
	_12X10, _12X11, _12X12),
	
	write('SOLUTION:'),
	nl,
	write('n1 = '), write(_2X2), nl,
	 write('n2 = '), write(_2X3), nl,
	  write('n3 = '), write(_2X6), nl,
	   write('n4 = '), write(_2X8), nl,
	    write('n5 = '), write(_2X10), nl,
		 write('n6 = '), write(_2X11), nl,
		  write('n7 = '), write(_3X3), nl,
		   write('n8 = '), write(_3X4), nl,
		    write('n9 = '),write(_3X6), nl,
			 write('n10 = '), write(_3X7), nl,
			  write('n11 = '), write(_3X8), nl,
			   write('n12 = '), write(_3X10), nl,
			    write('n13 = '), write(_3X11), nl,
				 write('n14 = '), write(_3X12), nl,
				  write('n15 = '), write(_4X2), nl,
				   write('n16 = '), write(_4X3), nl,
				    write('n17 = '), write(_4X4), nl,
					 write('n18 = '), write(_4X5), nl,
					  write('n19 = '), write(_4X8), nl,
					   write('n20 = '), write(_4X9), nl,
					    write('n21 = '), write(_4X11), nl,
						 write('n22 = '), write(_4X12), nl,
						  write('n23 = '), write(_5X4), nl,
						   write('n24 = '), write(_5X5), nl,
						    write('n25 = '), write(_5X6), nl,
							 write('n26 = '), write(_5X9), nl,
							  write('n27 = '),	write(_5X10), nl,
							   write('n28 = '), write(_6X2), nl,
							    write('n29 = '), write(_6X3), nl,
								 write('n30 = '), write(_6X4), nl,
								  write('n31 = '), write(_6X5), nl,
								   write('n32 = '), write(_6X6), nl,
								    write('n33 = '), write(_6X8), nl,
									 write('n34 = '), write(_6X9), nl,
									  write('n35 = '), write(_6X10), nl,
									   write('n36 = '), write(_6X12), nl,
									    write('n37 = '), write(_7X2), nl,
										 write('n38 = '), write(_7X3), nl,
										  write('n39 = '), write(_7X11), nl,
										   write('n40 = '),	write(_7X12), nl,
										    write('n41 = '), write(_8X2), nl,
											 write('n42 = '), write(_8X3), nl,
											  write('n43 = '), write(_8X4), nl,
											   write('n44 = '), write(_8X5), nl,
											    write('n45 = '), write(_8X6), nl,
												 write('n46 = '), write(_8X8), nl,
												  write('n47 = '), write(_8X9), nl,
												   write('n48 = '), write(_8X10), nl,
												    write('n49 = '), write(_8X11), nl,
													 write('n50 = '), write(_8X12), nl,
													  write('n51 = '), write(_9X5), nl,
													   write('n52 = '), write(_9X6), nl,
													    write('n53 = '), write(_9X8), nl,
														 write('n54 = '), write(_9X10), nl,
														  write('n55 = '), write(_10X2), nl,
														   write('n56 = '), write(_10X3), nl,
														    write('n57 = '), write(_10X4), nl,
															 write('n58 = '), write(_10X5), nl,
															  write('n59 = '), write(_10X6), nl,
															   write('n60 = '), write(_10X8), nl,
															    write('n61 = '), write(_10X9), nl,
																 write('n62 = '), write(_10X10), nl,
																  write('n63 = '), write(_10X11), nl,
																   write('n64 = '), write(_10X12), nl,
																    write('n65 = '), write(_11X2), nl,
																	 write('n66 = '), write(_11X3), nl,
																	  write('n67 = '), write(_11X4), nl,
																	   write('n68 = '), write(_11X6), nl,
																	    write('n69 = '), write(_11X7), nl,
																		 write('n70 = '), write(_11X8), nl,
																		  write('n71 = '), write(_11X10), nl,
																		   write('n72 = '), write(_11X12), nl,
																		    write('n73 = '), write(_12X2), nl,
																			 write('n74 = '), write(_12X3), nl,
																			  write('n75 = '), write(_12X6), nl,
																			   write('n76 = '), write(_12X7), nl,
																			    write('n77 = '), write(_12X10), nl,
																				 write('n78 = '), write(_12X11), nl,
																				  write('n79 = '), write(_12X12), nl,nl,nl,
	
	fail.
	
go :- write('End of go.').

% Solve the given puzzle
solve( _2X2, _2X3, _2X6, _2X8, _2X10, _2X11, _3X3, _3X4, _3X6, _3X7, _3X8, _3X10, _3X11,
	_3X12, _4X2, _4X3, _4X4, _4X5, _4X8, _4X9, _4X11, _4X12, _5X4, _5X5, _5X6, _5X9,
	_5X10, _6X2, _6X3, _6X4, _6X5, _6X6, _6X8, _6X9, _6X10, _6X12, _7X2, _7X3, _7X11,
	_7X12, _8X2, _8X3, _8X4, _8X5, _8X6, _8X8, _8X9, _8X10, _8X11, _8X12, _9X5, _9X6,
	_9X8, _9X10, _10X2, _10X3, _10X4, _10X5, _10X6, _10X8, _10X9, _10X10, _10X11, _10X12,
	_11X2, _11X3, _11X4, _11X6, _11X7, _11X8, _11X10, _11X12, _12X2, _12X3, _12X6, _12X7,
	_12X10, _12X11, _12X12) :-

	/*
	The only argument for this cross_sum(+List) is a list of lists call them each a Sum.
	For each of these Sum lists the first element is the intended 
	integer summation of the values that are stored in the second element of Sum.
	This second element is a list of integers or variables that are sub-permutations from 
	the set of integers [1-9]. The varaibles will follow the format
	'_[row number]X[column number]'. These variables (or integer value lists) will be listed 
	left-to-right or top-to-bottom depending on where each Sum is positioned on the board.
	*/
	time(cross_sum(		
		[
		/* top left corner */
		[10, [_2X2, _2X3, 7]],
		[10, [_2X2, 3, _4X2]],
		[9, [3, _3X3, _3X4]],
		[9, [_2X3, _3X3, _4X3]],
		[16, [_4X2, _4X3, _4X4, _4X5, 1]],
		[17, [7, _3X4, _4X4, _5X4, _6X4]],
		
		/* center section, top left */
		[7, [_5X4, _5X5, _5X6]],
		[11, [_4X5, _5X5, _6X5]],
		[15, [_6X2, _6X3, _6X4, _6X5, _6X6]],
		[18, [_2X6, _3X6, 1, _5X6, _6X6]],
		
		/* top middle */
		[22, [_2X6, 9, _2X8]],
		[17, [9, _3X7]],
		[15, [_3X6, _3X7, _3X8]],
		[24, [_2X8, _3X8, _4X8, 5, _6X8]],
		
		/* left middle */
		[14, [_6X3, _7X3, _8X3]],
		[16, [_7X2, _7X3]],
		[17, [_6X2, _7X2, _8X2]],
		
		/* center section, top right */
		[8, [5, _5X9, _5X10]],
		[13, [_4X9, _5X9, _6X9]],
		[15, [_4X8, _4X9, 2, _4X11, _4X12]],
		[26, [_6X8, _6X9, _6X10, 2, _6X12]],
		
		/* top right corner */
		[18, [6, _3X12, _4X12]],
		[16, [_2X10, _3X10, 2, _5X10, _6X10]],
		[15, [_2X10, _2X11, 6]],
		[17, [_2X11, _3X11, _4X11]],
		[21, [_3X10, _3X11, _3X12]],
		
		/* right middle */
		[8, [_6X12, _7X12, _8X12]],
		[10, [_7X11, _7X12]],
		[19, [2, _7X11, _8X11]],
		
		/* bottom left corner */
		[8, [_12X2, _12X3, 4]],
		[10, [_10X2, _11X2, _12X2]],
		[7, [_11X2, _11X3, _11X4]],
		[12, [_10X3, _11X3, _12X3]],
		
		/* bottom middle */
		[6, [_11X7, _12X7]],
		[9, [_12X6, _12X7, 3]],
		[6, [_11X6, _11X7, _11X8]],
		
		/* center section, bottom right */
		[9, [_9X8, 4, _9X10]],
		[12, [_8X9, 4, _10X9]],
		[15, [_8X8, _9X8, _10X8, _11X8, 3]],
		[25, [_8X8, _8X9, _8X10, _8X11, _8X12]],
		
		/* bottom right corner */
		[14, [_11X10, 7, _11X12]],
		[7, [_10X12, _11X12, _12X12]],
		[13, [_12X10, _12X11, _12X12]],
		[21, [_10X11, 7, _12X11]],
		[18, [_10X8, _10X9, _10X10, _10X11, _10X12]],
		[17, [_8X10, _9X10, _10X10, _11X10, _12X10]],
		
		/* center section, bottom left */
		[18, [6, _9X5, _9X6]],
		[15, [_8X6, _9X6, _10X6, _11X6, _12X6]],
		[24, [_8X4, 6, _10X4, _11X4, 4]],
		[25, [_8X2, _8X3, _8X4, _8X5, _8X6]],
		[21, [_8X5, _9X5, _10X5]],
		[31, [_10X2, _10X3, _10X4, _10X5, _10X6]]
		
		
		] /* end first argument for cross_sum(+List) */
		
	) /* end cross_sum(+List) */
	) /* end time */
	.
	
%Enforce constraints
cross_sum([]).
cross_sum([ [Sum|[Variables]]|Cross_Sum_Tail]) :-
	
	populate_vars(Sum, Variables, Distinct_Values),
	
	check_sum(Sum, Distinct_Values),
	
	cross_sum(Cross_Sum_Tail).

%Give the List of variables distinct values from the set [1,9]
%Designed so it will keep trying new values during backtracking
populate_vars(_, [], []).
populate_vars(Sum, [Next_Var|Rest_Var], [Next_Var|Rest_Distinct]) :-
	
	populate_aux(Next_Var),
	
	Next_Var < Sum,
	
	populate_vars(Sum, Rest_Var, Rest_Distinct),
		
	\+ member(Next_Var, Rest_Distinct).
	
populate_aux(1).
populate_aux(2).
populate_aux(3).
populate_aux(4).
populate_aux(5).
populate_aux(6).
populate_aux(7).
populate_aux(8).
populate_aux(9).

%Check to see that Sum is the summation of the values in the second argument list
%Notice this is done specifically for the amount of variables that could occur
%in a certain size kakuro puzzle
check_sum(Sum, [A, B]) :-
	Sum is A + B.
	
check_sum(Sum, [A, B, C]) :-
	Sum is A + B + C.

check_sum(Sum, [A, B, C, D, E]) :-
	Sum is A + B + C + D + E.

%Print the cputime
print_time :-
	write('The current cputime is '),
	write(cputime),
	write('.'),
	nl.
