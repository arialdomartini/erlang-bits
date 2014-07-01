-module(funs).
-export([run/0, direct/0, double_all/1, plus1_all/1, evens/1, palindroms/1, print_all/1, multiply/2]).

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


evens(X)      -> filter(fun(A) -> A rem 2 == 0    end, X).
    
palindroms(X) -> filter(fun(A) -> A == reverse(A) end, X).
    

filter(_, []) -> [];
filter(F, [X | Xs]) ->
    case F(X) of
        true -> [ X | filter(F, Xs)];
        _ -> filter(F, Xs)
    end. 


foreach([], _) -> ok;
foreach([X | Xs], F) -> 
    F(X),
    foreach(Xs, F).


print_all(X) ->
    foreach(X, fun(Item)-> io:format("element: ~p~n", [Item]) end).


times(N) ->
    fun(X) -> X * N end.

multiply(A, B) ->
    F = times(B),
    F(A).
