-module(funs).
-export([run/0, direct/0, double_all/1, plus1_all/1]).

run() ->
    Bump = fun(Int) ->
                   Int + 1 end,
    Bump(100).

direct() ->
    (fun(Int) -> Int + 1 end)(4).


double_all([]) -> [];
double_all([X|Xs]) -> [X*2 | double_all(Xs)].
    

plus1_all([]) -> [];
plus1_all([X|Xs]) -> [X + 1 | plus1_all(Xs)].
