-module(echo).
-export([go/0, loop/0]).

go() ->
    Pid = spawn(echo, loop, []),
    Pid ! {self(), hello},
    receive
        {Pid, Message} -> io:format("~w~n", [Message])
    end,
    Pid ! stop.

loop() ->
    receive
        { From, Message } ->
            From ! {self(), Message },
            loop;
        stop -> true
    end.