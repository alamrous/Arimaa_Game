:- module(bot,
      [  get_moves/3
      ]).

	
% A few comments but all is explained in README of github

% get_moves signature
% get_moves(Moves, gamestate, board).

% Exemple of variable
% gamestate: [side, [captured pieces] ] (e.g. [silver, [ [0,1,rabbit,silver],[0,2,horse,silver] ]) 
% board: [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]

% Call exemple:
 %et_moves(Moves, [silver, []], [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]).

% default call
element(X,[X|Q]).
element(X,[T|Q]) :- element(X,Q).
get_moves(Mo, Gamestate, Board):-deplacement(X,Y,A,B,Board),traverse(X,Y,A,Board),!,Mo=[[[X,Y],[A,B]]].
%get_moves(Mo, Gamestate, Board):-element([3,0,_,silver],Board),nonmember([4,0|_],Board),!,Mo=[[[3,0],[4,0]],[[3,1],[4,1]]].
%get_moves(Mo, Gamestate, Board):-Mo=[[[4,0],[3,0]],[[4,1],[3,1]]].



nonmember(Arg,[Arg|_]) :-
        !,
        fail.
nonmember(Arg,[_|Tail]) :-
        !,
        nonmember(Arg,Tail).
nonmember(_,[]).

renvoiex(X,Board):-element(X,[0,1,2,3,4,5,6,7]),element([X,_,_,silver],Board) .
renvoiey(X,Board):-element(Y,[0,1,2,3,4,5,6,7]),element([_,Y,_,silver],Board).
renvoiea(A,Board):-element(A,[0,1,2,3,4,5,6,7]).
renvoieb(B,Board):-element(B,[0,1,2,3,4,5,6,7]).

deplacement(X,Y,A,B,Board):-element([X,Y,rabbit,silver],Board),!,renvoiex(X,Board),renvoiey(Y,Board),element([X,Y,_,silver],Board),renvoiea(A,Board),renvoieb(B,Board),nonmember([A,B|_],Board),X=<A.
deplacement(X,Y,A,B,Board):-renvoiex(X,Board),renvoiey(Y,Board),element([X,Y,_,silver],Board),renvoiea(A,Board),renvoieb(B,Board),nonmember([A,B|_],Board).

traverse(X,Y,A,Board):- element(V,[0,1,2,3,4,5,6,7]),V=<A,V>X,!,nonmember([V,Y|_],Board).