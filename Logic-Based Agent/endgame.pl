:- use_module(library(clpfd)).
:- discontiguous positionS/5.
:- discontiguous positionS/4.
:- discontiguous positionIM/3.
gridSize(5, 5).
positionIM(1, 2, s0).
positionTH(3, 4).
positionS(1, 1, stone_1).
positionS(2, 1, stone_2).
positionS(2, 2, stone_3).
positionS(3, 3, stone_4).


positionS(1, 1, stone_1, not_collected, s0).
positionS(2, 1, stone_2, not_collected, s0).
positionS(2, 2, stone_3, not_collected, s0).
positionS(3, 3, stone_4, not_collected, s0).


%Could be added that IM can not enter the cell of thanos
%Successor state axiom for iron man position.
positionIM(X, Y, result(A, S)) :-
    %effect axioms
    gridSize(Height, Width),
    X in 0..Height,
    Y in 0..Width,
    %effect of up on the previous position
    (X1 #= X + 1,
    Y1 #= Y,
    positionIM(X1, Y1, S),
    A = up,
    print(up),
    nl);
    %effect of left on the previous position
    (X1 #= X,
    Y1 #= Y + 1,        
    positionIM(X1, Y1, S),
    A = left,
    print(left),
    nl);
    %effect of down on the previous position
    (X1 #= X - 1,
    Y1 #= Y,        
    positionIM(X1, Y1, S),
    A = down,
    print(down),
    nl);%effect of right on the previous position
    (X1 #= X,
    Y1 #= Y - 1,        
    positionIM(X1, Y1, S),
    A = right,
    print(right),
    nl);
    %Persistance axioms when action is not movement and the previous position is the same as the current position   
    (positionIM(X, Y, S),
    A \= left,
    A \= right,
    A \= up,
    A \= down).


positionS(X, Y, Stone, collected, result(A, S)) :-
    gridSize(Height, Width),
    X in 0..Height,
    Y in 0..Width,
    %Effect Axioms
    (positionS(X, Y,Stone, not_collected, S),
    A = collect, positionIM(X,Y,S)
        );
    %Persistance    
    (positionS(X,Y, Stone, collected, S), A \= collect),
    print(Stone).

%Successor state axiom for IM to be holding certain stone
%Only effect axioms needed as there is no action to drop the stones
holdingStone(Stone, result(A, S)) :-
    gridSize(Height, Width),
    ((positionIM(X, Y, S),
    X in 0..Height,
    Y in 0..Width,
    positionS(X, Y, Stone),
    A = collect);
    %IM will surely be holding stone S if it was holding it in the previous situation S
    holdingStone(Stone, S)),
    print(Stone).



% snapped(S) :-
%     holdingStone(s1, S),
%     holdingStone(s2, S),
%     holdingStone(s3, S),
%     holdingStone(s4, S),
%     positionIM(X, Y, S),
%     positionTH(X, Y),
%     S = result(snap, S).
    
snapped(S) :-
    positionS(1, 1, stone_1, collected, S),
    positionS(2, 1, stone_2, collected, S),
    positionS(2, 2, stone_3, collected, S),
    positionS(3, 3, stone_4, collected, S),
    positionIM(X, Y, S),
    positionTH(X, Y),
    S = result(snap, S).
    
snapped_with_limit(S, Limit) :-
    call_with_depth_limit(snapped(S), Limit, S);
    Limit1 is Limit + 1,
    snapped_with_limit(S, Limit1).
    
