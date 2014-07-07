-module(lists_demo).
-export([run/0]).
-export([is_greater_than/2]).

is_greater_than(X, Y) ->
    X > Y.

run() ->
    X = [1, 2, 3, 4, 5],
    Y = [3, 4, 5, 6, 7],
    If_greater_than_2 = fun(R) -> lists_demo:is_greater_than(R, 2) end,
    {X, lists:all(If_greater_than_2, X), Y, lists:all(If_greater_than_2, Y)}.
