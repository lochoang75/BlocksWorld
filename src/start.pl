#!/usr/bin/env swipl
write(’Hello World!’), nl.
bigger(elephant, horse).
bigger(horse, donkey).
bigger(donkey, dog).
bigger(donkey, monkey).
bigger(monkey, dog).
is_bigger(X, Y) :- bigger(X, Y).
is_bigger(X, Y) :- bigger(X, Z), is_bigger(Z, Y).



clear(a).
clear(c).
on(c,b).
onTable(a).
onTable(b).

%query:
%on(a,b),on(b,c).


move_to_table(X) :-
    on(X,Y),
    clear(X).



%move_to_table(X).