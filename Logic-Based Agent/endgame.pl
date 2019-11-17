gridSize(5, 5).
positionIM(1, 2, s0).
positionTH(3, 4).
positionS(1, 1, s1).
positionS(2, 1, s2).
positionS(2, 2, s3).
positionS(3, 3, s4).

%Could be added that IM can not enter the cell of thanos
%Successor state axiom for iron man position.
positionIM(X, Y, result(A, S)) :-
    %effect axioms
    gridSize(Height, Width),
    %effect of up on the previous position
    (positionIM(X1, Y1, S),
    X1 is X - 1,
    Y1 is Y,
    A = up,
    X1 >= 0);
    %effect of up on the previous position
    (positionIM(X1, Y1, S),
    X1 is X,
    Y1 is Y - 1,
    A = left,
    Y1 >= 0);
    %effect of up on the previous position
    (positionIM(X1, Y1, S),
    X1 is X + 1,
    Y1 is Y,
    A = down,
    X1 < Height);
    %effect of up on the previous position
    (positionIM(X1, Y1, S),
    X1 is X,
    Y1 is Y + 1,
    A = right,
    Y1 < Width);
    %Persistance axioms when action is not movement and the previous position is the same as the current position   
    (positionIM(X, Y, S),
    A \= left,
    A \= right,
    A \= up,
    A \= down).

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