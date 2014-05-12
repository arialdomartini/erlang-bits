-module(recursion).
-export([add_1/1, average/1]).

add_1([]) -> [];
add_1([Head | Tail]) -> [Head +1 | add_1(Tail)].

sum([]) -> 0;
sum( [H|T] ) -> H + sum(T).

len([]) -> 0;
len( [ _|T ] ) -> 1 + len(T).

average(List) ->
    sum(List) / len(List).
