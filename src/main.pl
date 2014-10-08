#!/usr/bin/env swipl


%INITIAL_STATE
holds(clear(a),s0).
holds(clear(c),s0).
holds(on(c,b),s0).
holds(onTable(a),s0).
holds(onTable(b),s0).


%ADD_Effects
holds(on(X,Y),do(stack(X,Y),S)).
holds(onTable(X),do(unstack(X,Y),S)).
holds(clear(Y),do(unstack(X,Y),S)).
holds(on(X,Z),do(move(X,Y,Z),S)).
holds(clear(Y),do(move(X,Y,Z),S)).


%General rule of Situation calculus
holds(F,do(A,S)) :-
    poss(A,S),
    holds(F,S), 
    not(affects(A,F)).

    
    
# not(unstack(X1,Y1) = stack(X2,Y2)).
# not(unstack(X1,Y1) = move(X2,Y2,Z2)).
# not(stack(X1,Y1) = move(X2,Y2,Z2)).



%UNSTACK
%preconditions
poss(unstack(X,Y),S):-
    holds(on(X,Y),S),                      %avoide unstack from table
    holds(clear(X),S).                     %the block must be clear


%STACK
%preconditions

poss(stack(X,Y),S):- 
    holds(onTable(X),S),
    holds(clear(X),S),
    holds(clear(Y),S),                      %the block must be clear
    X\=Y.                                   %avoide stacking a block in itself 
%MOVE
%preconditions 
poss(move(X,Y,Z),S):-
    holds(on(X,Y),S),                      %avoide to move to the same place it was
    holds(clear(X),S),                     
    holds(clear(Z),S),
    X\=Z.

%UNSTACK
%REM_Effects
affects(unstack(X,Y),on(X,Y)).
%STACK
%REM_Effects
affects(stack(X,Y),clear(Y)).
affects(stack(X,Y),onTable(X)).
%MOVE
%REM_Effects
affects(move(X,Y,Z),clear(Z)).
affects(move(X,Y,Z),on(X,Y)).
    
    

exec(s0).
exec(do(A,S)) :- poss(A,S), exec(S).


plan(s0).
plan(do(A,S)) :- plan(S).
