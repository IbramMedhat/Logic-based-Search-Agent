:- use_module(library(clpfd)).


grid(5,5).
posS(1,1,stone_1).
posS(2,1,stone_2).
posS(2,2,stone_3).
posS(3,3,stone_4).
posTH(3,4).

posIM(1,2,s0).


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

stone_collected(Stone, X , Y , result(A, S)):-
    (A = left , Y_old #= Y + 1 , stone_collected(Stone, X , Y_old, S) );
    (A = right , Y_old #= Y - 1 , stone_collected(Stone, X , Y_old, S) );
    (A = down , X_old #= X - 1 , stone_collected(Stone, X_old , Y, S) );
    (A = up , X_old #= X + 1 , stone_collected(Stone, X_old , Y, S) );
    (A = snap, stone_collected(Stone, X, Y, S));

    (A = collect, posS(X, Y, Stone));
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
    

