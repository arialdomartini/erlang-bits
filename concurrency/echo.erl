-module(echo).
-export([go/0, loop/0]).

go() ->
    register(hello, spawn(echo, loop, [])),
    hello ! {self(), hello},
    receive
        {Pid, Message} -> io:format("~w~n", [Message])
    end,
    hello ! stop.

loop() ->
    receive
        { From, Message } ->
            From ! {self(), {received, Message} },
            loop;
        stop -> true
    end.