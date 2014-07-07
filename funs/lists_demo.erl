-module(lists_demo).
-export([all/0, any/0]).
-export([is_greater_than/2]).
-export([allows/1]).

is_greater_than(X, Y) ->
    X > Y.

all() ->
    X = [1, 2, 3, 4, 5],
    Y = [3, 4, 5, 6, 7],
    If_greater_than_2 = fun(R) -> lists_demo:is_greater_than(R, 2) end,
    {X, lists:all(If_greater_than_2, X), Y, lists:all(If_greater_than_2, Y)}.

allows(X) ->
    X == yes.

any() ->
    X = [no, nada, niet, yes],
    {X, lists:any(fun lists_demo:allows/1, X)}.
