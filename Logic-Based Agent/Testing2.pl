:- use_module(library(clpfd)).

grid(0,2).
posS(0,1,stone_1).
posS(0,2,stone_2).
posIM(0,0,s0).


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

stone_collected(Stone,L_in,L_out, result(A, S)):-

    %Effect
    (
        % implies(
            Stone \= iron_man,
            not(check_element(L_in, Stone)),
            append(L_in, [Stone], L_out),            
            posS(X,Y, Stone), posIM(X,Y,S),
            % (stone_collected(OtherStone, S), Stone \= OtherStone)
            A = collect,
            print(collect),nl
        % )
    );
    %Persistance
    (
        
        Stone \= iron_man, check_element(L_in,Stone),  L_out = L_in,(  ( posS(X,Y, Stone) , posIM(X,Y, S) ->  (A = left; A = right;A = down;A = up) ;
         (A = collect; A = left; A = right;A = down;A = up) ) 
        

        ) 
    ).

snapped(S):-
    stone_collected(stone_1, [], L1, S1),
    stone_collected(stone_2,L1, L2 ,S1),

    posIM(0,2,S1),
    S = result(snap, S1).
% snapped_with_limit(S, Limit) :-
%     call_with_depth_limit(snapped(S), Limit, S);
%     Limit1 is Limit + 1,
%     snapped_with_limit(S, Limit1).

% stone_collected_w(s)
    

implies(X, Y):-
    not(X) ; Y.

check_element([X], X).
check_element([H|T], X):-
    H = X -> true ; 
    check_element(T, X).
% check_element([], _):-
%     false.
