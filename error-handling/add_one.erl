-module(add_one).
-export([start/0, request/1, loop/0]).

start() ->
    io:format("Try also running a process_flag(trap_exit, true) from the shell, then flush() after the crash happened~n"),
    register(add_one, spawn_link(?MODULE, loop, [])).

request(Int) ->
    add_one ! {request, self(), Int},
    receive
        {result, Result} ->
            Result
    after 1000 -> timeout
    end.

loop() ->
    receive
        {request, Pid, Int} ->
            Pid ! {result, Int + 1}
    end,
    loop().
