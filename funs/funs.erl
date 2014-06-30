-module(funs).
-export([run/0, direct/0, double_all/1, plus1_all/1, evens/1, palindroms/1]).

run() ->
    Bump = fun(Int) ->
                   Int + 1 end,
    Bump(100).

direct() ->
    (fun(Int) -> Int + 1 end)(4).

map(_,[]) -> [];
map(F, [X|Xs]) -> [ F(X) | map(F, Xs) ].

double_all(List) -> map( double, List).

plus1_all(List) -> map (fun(X) -> X+1 end ,List).

reverse(List) -> reverse_acc(List, []).

reverse_acc([], Acc) -> Acc;
reverse_acc([X|Xs], Acc) -> reverse_acc(Xs, [X | Acc]).


evens([]) -> [];
evens([X | Xs]) ->
    case X rem 2 == 0 of
        true -> [ X | evens(Xs)];
        _ ->    [     evens(Xs)]
    end.
    
palindroms([]) -> [];
palindroms([X | Xs]) ->
    case X == reverse(X) of
        true -> [ X | palindroms(Xs)];
        _ ->    [     palindroms(Xs)]
    end.
    
 
