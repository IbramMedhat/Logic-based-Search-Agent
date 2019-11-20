:- use_module(library(clpfd)).

grid(5,5).
posS(1,1,stone_1).
posS(2,1,stone_2).
posS(2,2,stone_3).
posS(3,3,stone_4).

posIM(1,2,s0).


posIM(X_new,Y_new ,result(A,S)):-

    %Effect
    (
        grid(Height,Width),
        X_new in 0..Height,
        X_old in 0..Height,
        Y_new in 0..Width,
        Y_old in 0..Width,
        posIM(X_old, Y_old,S),
        (
            (A = left, X_new #= X_old , Y_new #= Y_old - 1);
            (A = right, X_new #= X_old , Y_new #= Y_old + 1);
            (A = down, X_new #= X_old + 1 , Y_new #= Y_old);
            (A = up, X_new #= X_old - 1 , Y_new #= Y_old)
        )
    )

        ;
    %Persistance
    (
        % implies(
            (grid(Height,Width),
            X_new in 0..Height,
            X_old in 0..Height,
            Y_new in 0..Width,
            Y_old in 0..Width,
            X_new #= X_old,
            Y_new #= Y_old),
            posIM(X_old, Y_old, S),
            A = collect
            
        % )
    ).

% pos(X_new,Y_new , iron_man, result(A,S)):-
%     pos(X_new,Y_new, iron_man, S),
%     A = collect.

stone_collected(Stone, result(A, S)):-

    %Effect
    (
        % implies(
            Stone \= iron_man,
            posS(X,Y, Stone), posIM(X,Y,S),
            %not(stone_collected(Stone, S)),
            % (stone_collected(OtherStone, S), Stone \= OtherStone)
            A = collect,
            print(collect),print(Stone), nl
        % )
    );
    %Persistance
    (
        
        Stone \= iron_man, stone_collected(Stone, S),  (  (  posS(X,Y, Stone), posIM(X,Y, S)   ->  (A = left; A = right;A = down;A = up) ;
         (A = collect; A = left; A = right;A = down;A = up) ) 
        

        ) 
    ).

snapped(S):-
    S = result(snap,S1),
    stone_collected(stone_1, S1),
    stone_collected(stone_2, S1),
    stone_collected(stone_3, S1),
    stone_collected(stone_4, S1),
    posIM(3,4,S1).
    %posIM(0,2,S).

snapped_with_limit(S, Limit) :-
    call_with_depth_limit(snapped(S), Limit, S);
    Limit1 is Limit + 1,
    snapped_with_limit(S, Limit1).

% stone_collected_w(s)
    

implies(X, Y):-
    not(X) ; Y.
    

pos(2).
collected(2).
collected(1).