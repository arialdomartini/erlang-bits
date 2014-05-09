-module(recursion).
-export([add_1/1]).

add_1([]) -> [];
add_1([Head | Tail]) -> [Head +1 | add_1(Tail)].
    