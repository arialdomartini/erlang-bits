-module(funs).
-export([run/0, direct/0, double_all/1, plus1_all/1]).

run() ->
    Bump = fun(Int) ->
                   Int + 1 end,
    Bump(100).

direct() ->
    (fun(Int) -> Int + 1 end)(4).

map(_,[]) -> [];
map(F, [X|Xs]) -> [ F(X) | map(F, Xs) ].

double_all(List) -> map( fun(X) -> X*2 end, List).

plus1_all(List) -> map (fun(X) -> X+1 end ,List).


