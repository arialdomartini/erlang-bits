-module(recursion).
-export([
    add_1/1, 
    add_1_with_accumulating_parameter/1, 
    average/1, 
    average_two_accs/1,
    filter_even/1, 
    exists/2, 
    sum_recursive/1, 
    sum_with_accumulating_parameter/1, 
    reverse/1,
    zip/2,
    sum_up_to/1,
    sum2/1
]).

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

sum_with_accumulating_parameter(List) -> sum_acc(0, List).

sum_acc(A, [E]) -> A + E;
sum_acc(A, [H|T]) -> sum_acc(A + H, T).

reverse(List) -> reverse_acc(List, []).

reverse_acc([], Acc) -> Acc;
reverse_acc([H|T], Acc) -> reverse_acc(T, [H | Acc ]).


zip(Xs, Ys) -> lists:reverse(zipL(Xs, Ys, [])).

zipL([], [], Acc) -> Acc;
zipL([X|Xs], Ys, Acc) -> zipR(Xs, Ys, [X|Acc]).

zipR([], [], Acc) -> Acc;
zipR(Xs, [Y|Ys], Acc) -> zipL(Xs, Ys, [Y|Acc]).

average_two_accs(List) -> average_acc(List, 0, 0).

average_acc([], Sum, Length) -> Sum / Length;
average_acc([H|T], Sum, Length) -> average_acc(T, Sum + H, Length + 1).


% int sum(int boundary) {
%    int sum = 0;
%    for(int i=1; i<=boundary; i++;) {
%        sum += i;
%    }
%    return sum;
% }

sum_up_to(N) -> sum_up_to_acc(N, 0).

sum_up_to_acc(0, Sum) -> Sum;
sum_up_to_acc(N, Sum) -> sum_up_to_acc(N-1, Sum+N).


sum2(Boundary) -> sum2_acc(1, Boundary, 0).

sum2_acc(Index, Boundary, Sum) when Index =< Boundary ->
    sum2_acc(Index+1, Boundary, Sum + Index);
sum2_acc(_, _, Sum) -> Sum.
