:- use_module(library(clpfd)).


grid(5, 5).
posS(2, 3, stone_1).
posS(3, 4, stone_2).
posS(4, 4, stone_3).
posS(4, 5, stone_4).
posTH(5, 5).
posIM(2, 2, s0).


posIM(X_new,Y_new ,result(A,S)):-

    %Effect as making sure first that iron man position is in bounds of the grid
    %Then moving iron man in different directions according to old position in the previous situation
    grid(Height,Width),
    X_new in 0..Height,
    X_old in 0..Height,
    Y_new in 0..Width,
    Y_old in 0..Width,
    posIM(X_old, Y_old,S),
    (
        
        (
            (A = left, X_new #= X_old , Y_new #= Y_old - 1);
            (A = right, X_new #= X_old , Y_new #= Y_old + 1);
            (A = down, X_new #= X_old + 1 , Y_new #= Y_old);
            (A = up, X_new #= X_old - 1 , Y_new #= Y_old);
            %Persistance case where iron man position does not change if previous action was collect
            (A = collect, X_old #= X_new , Y_old #= Y_new, posS(X_old, Y_old ,Stone), not(once(stone_collected(Stone,X_old,Y_old, S))))
        )
    ).


% case to assure that no stone is collected in the initial situation
stone_collected(_,_,_,s0):-
    false.

% This predicate is used to check if the stone "Stone" in the situation "result(A,S)" where iron man is at postion "X,Y"
% is collected or not.

% This predicate parses a given situation to check if this series of actions results in stone "Stone" being collected.
stone_collected(Stone, X , Y , result(A, S)):-
    % Here we check if the last action was one of the movement operators, and then we update the X,Y accordingly and
    % call the predicate on the rest of the situation (Without the last action) with the new X,Y.
    (A = left , Y_old #= Y + 1 , stone_collected(Stone, X , Y_old, S) );
    (A = right , Y_old #= Y - 1 , stone_collected(Stone, X , Y_old, S) );
    (A = down , X_old #= X - 1 , stone_collected(Stone, X_old , Y, S) );
    (A = up , X_old #= X + 1 , stone_collected(Stone, X_old , Y, S) );

    % Here we just check if the last action was "snap", if it is we just pass the rest of the sitation to the preidacte again
    % with the same X and Y.
    (A = snap, stone_collected(Stone, X, Y, S));

    % Here we check if the last action was "collect" and the current pos of iron man (X,Y) is the same as the mentioned stone
    % "Stone" , the predicate returns true.
    (A = collect, posS(X, Y, Stone));

    % IF not the predicate will remove the last action and continue checking.
    (A = collect, not(posS(X, Y, Stone)) , stone_collected(Stone, X, Y, S)).
    

snapped(S):-
    S = result(snap,S1),
    posIM(X,Y,S1),
    posTH(X,Y),
    stone_collected(stone_1, X, Y,S1),
    stone_collected(stone_2, X, Y,S1),
    stone_collected(stone_3, X, Y,S1),
    stone_collected(stone_4, X, Y,S1).

snapped_with_limit(S, Limit) :-
    call_with_depth_limit(snapped(S), Limit, S);
    Limit1 is Limit + 1,
    snapped_with_limit(S, Limit1).

    

implies(X, Y):-
    not(X) ; Y.
    

