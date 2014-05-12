-module(recursion).
-export([add_1/1, add_1_with_accumulating_parameter/1, average/1, filter_even/1, exists/2, sum_recursive/1, sum_with_accumulating_parameter/1, reverse/1]).

add_1([]) -> [];
add_1([Head | Tail]) -> [Head +1 | add_1(Tail)].

add_1_with_accumulating_parameter(List) -> add_acc(List, []).

add_acc([], Acc) -> reverse(Acc);
add_acc([H|T], Acc) -> add_acc(T, [H+1 | Acc] ).

sum([]) -> 0;
sum( [H|T] ) -> H + sum(T).

len([]) -> 0;
len( [ _|T ] ) -> 1 + len(T).

average(List) ->
    sum(List) / len(List).

filter_even([]) -> [];
filter_even([H|T]) when H rem 2  == 0 -> [H|filter_even(T)];
filter_even([_|T]) -> filter_even(T).

exists( _, [] )        -> false;
exists( E, [E | _] )    -> true;
exists( E, [_ | T] )    -> exists(E, T).

sum_recursive( [E] ) -> E;
sum_recursive( [H|T] ) -> H + sum(T).

sum_with_accumulating_parameter(List) -> sum_to(0, List).

sum_to(A, [E]) -> A + E;
sum_to(A, [H|T]) -> sum_to(A + H, T).

reverse(List) -> reverse_acc(List, []).

reverse_acc([], Acc) -> Acc;
reverse_acc([H|T], Acc) -> reverse_acc(T, [H | Acc ]).