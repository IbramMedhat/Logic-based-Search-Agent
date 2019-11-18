gridSize(5, 5).
positionIM(1, 2, s0).
positionTH(3, 4).
positionS(1, 1, s1, s0).
positionS(2, 1, s2, s0).
positionS(2, 2, s3, s0).
positionS(3, 3, s4, s0).

%Could be added that IM can not enter the cell of thanos
%Successor state axiom for iron man position.
positionIM(X, Y, result(A, S)) :-
    %effect axioms
    gridSize(Height, Width),
    %effect of up on the previous position
    (positionIM(X1, Y1, S),
    X1 is X + 1,
    Y1 is Y,
    A = up,
    X >= 0);
    %effect of left on the previous position
    (positionIM(X1, Y1, S),
    X1 is X,
    Y1 is Y + 1,
    A = left,
    Y >= 0);
    %effect of down on the previous position
    (positionIM(X1, Y1, S),
    X1 is X - 1,
    Y1 is Y,
    A = down,
    X < Height);
    %effect of right on the previous position
    (positionIM(X1, Y1, S),
    X1 is X,
    Y1 is Y - 1,
    A = right,
    Y < Width);
    %Persistance axioms when action is not movement and the previous position is the same as the current position   
    (positionIM(X, Y, S),
    A \= left,
    A \= right,
    A \= up,
    A \= down).

positionS(X, Y, Stone, result(A, S)) :-
    positionS(X, Y, Stone, S),
    A \= collect.

%Successor state axiom for IM to be holding certain stone
%Only effect axioms needed as there is no action to drop the stones
holdingStone(Stone, result(A, S)) :-
    (positionIM(X, Y, S),
    positionS(Sx, Sy, Stone),
    X = Sx,
    Y = Sy,
    A = collect);
    %IM will surely be holding stone S if it was holding it in the previous situation S
    holdingStone(Stone, S).



snapped(S) :-
    holdingStone(s1, S),
    holdingStone(s2, S),
    holdingStone(s3, S),
    holdingStone(s4, S),
    positionIM(X, Y, S),
    positionTH(X, Y),
    S = result(snap, S).
    