-module(funs).
-export([run/0]).

run() ->
    Bump = fun(Int) ->
                   Int + 1 end,
    Bump(100).
