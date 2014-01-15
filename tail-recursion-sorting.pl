%File: Paul_Prae.Sorting.pl
%Author: Paul Prae
%Last Edited: November 1st, 2011
%Purpose: To learn more about tail recursion, cuts, and sorting in Prolog.
%For: Dr. Potter and CSCI 4540 Fall 2011 

%The UI
%Enter go to start interaction.
go :- 
	write('Welcome to Paul Prae''s Unsortedness Evaluator!'),
	nl, nl,
	write('This program will rank and evaluate a string of'),
	nl,
	write('numbers that you provide it against all possible'),
	nl,
	write('permutations of those numbers.'),
	nl, nl,
	write('We shall now begin!'),
	nl,
	write('Please enter in a comma delimited list of numbers'),
	nl,
	write('with nothing surrounding them and no duplicates.'),
	nl,
	write('e.g. ''1,2,3'' but without the single quotes.'),
	nl,
	write('Press ''Enter'' or ''Return'' after the last digit.'),
	nl,
	write('Your numbers please: '),
	read_str(String),
	nl,
	write('Thank you! Here we go...'),
	nl,nl,
	string_to_number_list(String, List),
	
	sort_evaluated_perms(List, Result),
	
	rank_order(Result, RankedResult),
	
	write('The rankings of all permutations of your list of numbers'),
	nl,
	write('according to evaluations by my unsortedness algorithm:'),
	nl,nl,
	write_ranks(RankedResult),
	nl,nl,
	find_rank_value(List, RankedResult, Rank, Value),
	
	write('The list of numbers you provided, '),
	
	write(List), write(' ,'),
	nl,
	write('evaluated to: '), write(Value),
	nl,
	write('and ranked: '), write(Rank),
	nl,
	write('among all other permutations of those same numbers.'),
	nl,nl,
	write('Sadly, in most cases, my algorithm evaluates a permutation'),
	nl,
	write('to a duplicate value of many others.'),
	nl,nl,
	write('Your permutation had the same value as '),
	how_many_dups(Value, RankedResult, ManyDups),
	OtherDups is ManyDups - 1,
	write(OtherDups), write(' other(s).'),
	nl,
	write('There may still be some useful convergences to notice though!'),
	nl,nl,
	write('That is all. Enter ''go'' to play again.'),
	nl,
	write('End of program. Goodbye.'),!.
	
	
%Convert a comma delimited string into a list of numbers
string_to_number_list(String, List) :-
	
	string_to_number_list_aux(String, [], [], List).

%Kluge
	
string_to_number_list_aux([], CurrentNumber, CurrentList, Result) :-

	number_codes(Number, CurrentNumber),
	
	append(CurrentList, [Number], Result), !. 
	
string_to_number_list_aux([44|StringT], CurrentNumber, CurrentList, Result) :-

	number_codes(Number, CurrentNumber),
	
	append(CurrentList, [Number], NewCurrentList),
	
	string_to_number_list_aux(StringT, [], NewCurrentList, Result), !.
	
string_to_number_list_aux([StringH|StringT], CurrentNumber, CurrentList, Result) :-

	append(CurrentNumber, [StringH], NewCurrentNumber),
	
	string_to_number_list_aux(StringT, NewCurrentNumber, CurrentList, Result), !.

%Create a list of perms, evaluate their unsortedness, then sort by this value
%sort_evaluated_perms(+ToPerm, -SortedList)
sort_evaluated_perms(List, Result) :-

	perms(List, Perms),

	unsortedness_lists(Perms, PermsEvaluated),

	sort(PermsEvaluated, Result), !.

%Add rankings to a sorted list, last item is ranked highest... so reverse the positions too
rank_order(List, Result) :-

	length(List, Length),

	rank_aux(List, [], Length, Result).
	
rank_aux([], Result, 0, Result) :- !.
	
rank_aux([H|T], Stack, Count, Result) :-

	append([Count], H, CountH),

	append([CountH], Stack, NewStack),
	
	NewCount is Count - 1,
	
	rank_aux(T, NewStack, NewCount, Result).
	
%Output the ranked list in a human readable form
write_ranks([]) :- !.

write_ranks([ [Rank, Value| List] | Rest ]) :-

	write('#'), write(Rank), write(': Value = '), write(Value),
	write(' for '), write(List), write('.'),nl,
	
	write_ranks(Rest), !.
	
%find the rank and value of a list of number from a ranked and evaluated list of perms
find_rank_value(List, RankedResult, Rank, Value) :-

	member([Rank, Value|List], RankedResult), !.

%Find out how many permutations have the same values
how_many_dups(Value, RankedResult, ManyDups) :-

	how_many_dups_aux(Value, RankedResult, 0, ManyDups), !.

how_many_dups_aux(_, [], ManyDups, ManyDups) :- !.
	
how_many_dups_aux(Value, [ [_,Value|_]|Rest ], Count, ManyDups) :-

	NewCount is Count + 1,
	
	how_many_dups_aux(Value, Rest, NewCount, ManyDups).
	
how_many_dups_aux(Value, [_|Rest], Count, ManyDups) :-
	how_many_dups_aux(Value, Rest, Count, ManyDups).
		
%Create all possible permutations of a given list with duplicates removed
%perms(+List, -List)
%+List will be a list of elements to create perumtations of 
%-List will be a list of those permutations (a list of lists)

perms([], [[]]) :- !.

perms(List, Result) :-
	
	remove_dups(List, SetList),
	
	length(SetList, Length),
	
	aux_perms(SetList, [], Result, 0, Length), !.
	
aux_perms(_, Result, Result, Length, Length).
	
aux_perms(List, CurrentPerms, ResultPerms, Count, Length) :-

	get_element(List, Count, Element),
	
	perms_without_element(List, Element, WithoutElement),
	
	append_to_each(Element, WithoutElement, WithElement),
	
	append(CurrentPerms, WithElement, NewCurrentPerms),
	
	NewCount is Count + 1,
	
	aux_perms(List, NewCurrentPerms, ResultPerms, NewCount, Length).
	
	
	
%Remove duplicate elements
%remove_dups(+List, -ResultList)

remove_dups(List, Result) :-
	
	aux_remove_dups(List, [], Result), !.

aux_remove_dups([], Result, Result).

aux_remove_dups([Head|Tail], CurrentResult, Result) :-

	remove_element(Head, Tail, TailWithoutHead),
	
	append(CurrentResult, [Head], NewCurrentResult),
	
	aux_remove_dups(TailWithoutHead, NewCurrentResult, Result).
	
%Remove an element from a list
%remove_element(+Element, +List, -ResultList)
remove_element(Element, List, Result) :-
	
	aux_remove_element(Element, List, [], Result).
	
aux_remove_element(_, [], Result, Result).

aux_remove_element(Element, [Head|Tail], CurrentResult, Result) :-

	remove_dup(Element, Head, NotDup),
	
	append(CurrentResult, NotDup, NewCurrentResult),
	
	aux_remove_element(Element, Tail, NewCurrentResult, Result).
	
%Given two elements if they are the same return an empty list.
%	If not return just the second element in a list.
%remove_dup(+Element1, +Element2, -Result)

remove_dup(Element, Element, []).

remove_dup(_, Element2, [Element2]).
	
%Get the element from a list at the location given, 0 is the first element
%get_element(+List, +Position, -Element)

get_element(List, Position, Element) :-

	length(List, Length),
	
	Position < Length,

	aux_get_element(List, Position, Element, 0), !.

aux_get_element([Element|_], Position, Element, Position). 

aux_get_element([_|Tail], Position, Element, Count) :-

	NewCount is Count + 1,

	aux_get_element(Tail, Position, Element, NewCount).


%Remove an element from a list then return the permutations of the new list
%	with the element removed.
%perms_without_element(+List, +Element, -Result)

perms_without_element(List, Element, Result) :-
	
	remove_element(Element, List, NewList),
	
	perms(NewList, Result).

%Append a given element as the head of every list of a given list of lists
%append_to_each(+Element, +List, -ResultList)

append_to_each(Element, [[]], [[Element]]).
	
append_to_each(Element, [[Head|HeadTail]|Tail], Result) :-
	
	aux_append_to_each(Element, [[Head|HeadTail]|Tail], [], Result), !.
		
aux_append_to_each(_, [], Result, Result).

aux_append_to_each(Element, [Head|List], CurrentResult, Result) :-

	append([Element], Head, HeadAppended),
	
	append(CurrentResult, [HeadAppended], NewCurrentResult),
	
	aux_append_to_each(Element, List, NewCurrentResult, Result).

%Given a list of lists of values determine the sublists of value unsortedness
%	append the unsortedness as the first element in the sublist
%unsortedness_lists(+ListOfLists, -ResultListOfLists)

unsortedness_lists(List, Result) :-

	aux_unsortedness_lists(List, [], Result), !.

aux_unsortedness_lists([], Result, Result).

aux_unsortedness_lists([First|Rest], CurrentResult, Result) :-

	unsortedness(First, Value),

	append([Value], First, ValueFirst),

	append(CurrentResult, [ValueFirst], NewCurrentResult),

	aux_unsortedness_lists(Rest, NewCurrentResult, Result).

%Given a list of integers return a value that indicates its unsortedness
%More positive means more sorted, negative values may exist
%unsortedness(+List, -Value)
unsortedness([], 0).

unsortedness(List, Value) :-

	aux_unsortedness(List, 0, 0, Value), !.

aux_unsortedness([_|[]], 0, 0, 0).

aux_unsortedness([_|[]], Count, Sum, Value) :-

	Value is Sum / Count.

aux_unsortedness([Element1, Element2|Rest], Count, Sum, Value) :-

	Difference is Element2 - Element1,

	Quotient is Difference / 2,

	NewSum is Sum + Quotient,

	NewCount is Count + 1,

	aux_unsortedness([Element2|Rest], NewCount, NewSum, Value).

%My quick sort
%Sort based on the value of the first element in the list
%quicky_sort(+List, -List)

quicky_sort([], []).

quicky_sort([H|[]], [H]).

quicky_sort([H|T], LessHGreater) :-

	q_partition([H|T], [], [], Less, Greater),

	quicky_sort(Less, LessResult),

	quicky_sort(Greater, GreaterResult),

	append(LessResult, [H], LessH),

	append(LessH, GreaterResult, LessHGreater).

q_partition([[_|_]| []], Less, Greater, Less, Greater).

q_partition([[PivotHead|PivotTail], [E2Head|E2Tail]| Rest], CurrentLess, CurrentGreater, Less, Greater) :-

	E2Head =< PivotHead,

	append(CurrentLess, [[E2Head|E2Tail]], NewCurrentLess),

	q_partition([[PivotHead|PivotTail]| Rest], NewCurrentLess, CurrentGreater, Less, Greater).

q_partition([[PivotHead|PivotTail], [E2Head|E2Tail]| Rest], CurrentLess, CurrentGreater, Less, Greater) :-

	E2Head > PivotHead,

	append(CurrentGreater, [[E2Head|E2Tail]], NewCurrentGreater),

	q_partition([[PivotHead|PivotTail]| Rest], CurrentLess, NewCurrentGreater, Less, Greater).


% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File READSTR.PL
% Reading and writing lines of text

% Uses get0, and works in almost all Prologs (not Arity).


% read_str(-String)
%   Accepts a whole line of input as a string (list of ASCII codes).
%   Assumes that the keyboard is buffered.

read_str(String) :- get0(Char),
                    read_str_aux(Char,String).

read_str_aux(-1,[]) :- !.    % end of file
read_str_aux(10,[]) :- !.    % end of line (UNIX)
read_str_aux(13,[]) :- !.    % end of line (DOS)

read_str_aux(Char,[Char|Rest]) :- read_str(Rest).


% read_atom(-Atom)
%  Reads a line of input and converts it to an atom.
%  See text concerning name/2 vs. atom_codes/2.

read_atom(Atom) :-
   read_str(String),
   name(Atom,String).    % or preferably atom_codes(Atom,String).


% read_num(-Number)
%  Reads a line of input and converts it to a number.
%  See text concerning name/2 vs. number_codes/2.

read_num(Atom) :-
   read_str(String),
   name(Atom,String).    % or preferably number_codes(Atom,String).


% write_str(+String)
%  Outputs the characters corresponding to a list of ASCII codes.

write_str([Code|Rest]) :- put(Code), write_str(Rest).
write_str([]).


% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File GETYESNO.PL
% Menu that obtains 'yes' or 'no' answer

get_yes_or_no(Result) :- get(Char),              % read a character
                         get0(_),                % consume the Return after it
                         interpret(Char,Result),
                         !.                      % cut -- see text

get_yes_or_no(Result) :- nl,
                         write('Type Y or N:'),
                         get_yes_or_no(Result).

interpret(89,yes).  % ASCII 89  = 'Y'
interpret(121,yes). % ASCII 121 = 'y'
interpret(78,no).   % ASCII 78  = 'N'
interpret(110,no).  % ASCII 110 = 'n'
