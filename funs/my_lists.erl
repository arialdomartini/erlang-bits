-module(my_lists).
-export([map/0]).
-export([map/2, double/1]).

double(X) ->
    2 * X.

map(Function, List) ->
    [Function(Item) || Item <- List].

map() ->
    map(fun my_lists:double/1, [1,2,3,4]).
