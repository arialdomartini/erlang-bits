-module(recursion).
-export([add_1/1, average/1, filter_even/1]).

add_1([]) -> [];
add_1([Head | Tail]) -> [Head +1 | add_1(Tail)].

sum([]) -> 0;
sum( [H|T] ) -> H + sum(T).

len([]) -> 0;
len( [ _|T ] ) -> 1 + len(T).

average(List) ->
    sum(List) / len(List).

filter_even([]) -> [];
filter_even([H|T]) when H rem 2  == 0 -> [H|filter_even(T)];
filter_even([H|T]) when H rem 2  == 1 -> filter_even(T).

