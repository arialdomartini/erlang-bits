-module(monitor).
-export([start/0, do/0, crash/0]).
-export([init/0]).

start() ->
    Pid = spawn(?MODULE, init, []),
    register(other, Pid),
    {ok, Pid, other}.

do() ->
    other ! {request, self(), do},
    receive
        {reply, Reply} -> {ok, Reply};
        _ -> other
    end.

crash() ->
    Reference = erlang:monitor(process, other),
    other ! {request, self(), crash},
    receive
        {'DOWN', Reference, process, Pid, Reason} -> 
            io:format("Oh, ~w crashed because ~w", [Pid, Reason]);
        Other -> Other
    end.


init() ->
    loop().

loop() ->
    receive
        {request, Pid, do} ->
            Pid ! {reply, ok},
            loop();
        {request, _Pid, crash} ->
            1/0
    end.


