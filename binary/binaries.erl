-module(binaries).
-export([run/0, bits/0, hello/0]).

run() ->
    Binary = term_to_binary({foo, bar, 12, "OK"}),
    io:format("~w~n", [Binary]),
    Orig = binary_to_term(Binary),
    io:format("~w~n", [Orig]),
    io:format("~w~n", [split_binary(Binary, 1)]).

bits() ->
    Bits = <<1,2,3>>,
    io:format("Bits: ~w, As list: ~w~n", [Bits, binary_to_list(Bits)]),
    <<A, _B, _C>> = Bits,
    io:format("First bit is ~w~n", [A]).

hello() ->
    <<72,101,108,108,111, 32, 100, 75, 80, 90, 60>>.
