-module(finite-state-machine).
-export([start/0, stop/0]).
-export([idle/0, ringing/0]).

start() ->
    register(phone, spawn(?MODULE, idle, [])).

idle() ->
    receive
        {Number, incoming} ->
            start_ringing(),
            ringing(Number);
        off_hook ->
            start_tone(),
            dial()
    end.

ringing(Number) ->
    receive
        {Number, other_on_hook} ->
            stop_ringing(),
            idle();
        {Number, off_hook} ->
            stop_ringing(),
            connected(Number)
    end.

start_ringing() ->
    io:format("DRIN DRIN~n").

start_tone() ->
    io:format("TOOT TOOT~n").

stop_ringing() ->
    io:format("PLONG~n").

