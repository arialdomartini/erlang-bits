-module(echo).
-export([go/0, loop/0]).

go() ->
    register(echo, spawn(echo, loop, [])),
    echo ! {self(), hello},
    receive
        {_Pid, Message} -> io:format("~w~n", [Message])
    end,
    {"Run whereis(echo) then send it a stop message"}.


loop() ->
    receive
        { From, Message } ->
            From ! {self(), {received, Message} },
            loop();
        stop -> true
    end.