-module(bin).
-export([run/0]).

run() ->
    Binary = term_to_binary({foo, bar, 12, "OK"}),
    io:format("~w~n", [Binary]),
    Orig = binary_to_term(Binary),
    io:format("~w~n", [Orig]).
