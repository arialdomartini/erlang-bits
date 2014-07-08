-module(my_lists).
-export([map/0]).
-export([map/2, double/1]).
-export([filter/0]).
-export([filter/2, is_even/1]).

double(X) ->
    2 * X.

map(Function, List) ->
    [Function(Item) || Item <- List].

map() ->
    map(fun my_lists:double/1, [1,2,3,4]).

is_even(X) ->
    X rem 2 == 0.

filter(Function, List) ->
    [Item || Item <- List, Function(Item) == true].

filter() ->
    filter(fun my_lists:is_even/1, [1,2,3,4,5,6]).
