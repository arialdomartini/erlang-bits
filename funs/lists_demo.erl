-module(lists_demo).
-export([all/0, any/0]).
-export([is_greater_than/2]).
-export([allows/1]).
-export([map/0]).
-export([double/1]).
-export([partition/0, is_female/1]).
-export([lazy_list/0, list_comprehension/0, extract/0, group/0]).

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

double(X) ->
    X * 2.

map() ->
    X = [1,2,3,4],
    lists:map(fun lists_demo:double/1, X).


is_female({_, female}) ->
    true;
is_female({_, male}) ->
    false.

partition() ->
    People = [ 
               {john, male},
               {jane, female},
               {tarzan, male},
               {karl, male},
               {bjorne, male},
               {lucrezia, female}
              ],
    Separated = lists:partition(fun lists_demo:is_female/1, People),
    io:format("~p~n", [Separated]).



next(Value) ->
    fun() -> [Value | next(Value+1)] end.

lazy_list() ->
    Numbers = next(10),
    [A | Rest] = Numbers(),
    io:format("~w~n", [A]),
    [B | _ ] = Rest(),
    io:format("~w~n", [B]).


list_comprehension() ->
    [ X *2 || X <- [1,2,3,4,5], X rem 2 == 0 ].

extract() ->
    Db = [
          {mario, italia},
          {john, great_britain},
          {fabien, france},
          {nikita, japan}
         ],
    [Name || {Name, _Nation} <- Db ].
    
group() ->
    Db = [
          {mario, italia},
          {john, great_britain},
          {fabien, france},
          {nikita, japan},
          {giulia, italia},
          {lucrezia, italia},
          {maryjane, great_britain},
          {luisette, france},
          {ani, japan}
         ],
    [ {Nation, [Person || {Person, Nat} <-Db, Nat == Nation  ]} || {_, Nation} <- Db  ].
