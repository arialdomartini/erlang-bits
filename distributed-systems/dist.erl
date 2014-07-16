-module(dist).
-export([remote_call/0, init/0]).

init() ->
    loop().

loop() ->
    receive
        {message, From} ->  From ! {reply_from, node()}
    end,
    loop().

remote_call() ->
    Remote = spawn('foo@macaco', dist, init, []),
    Remote ! {message, self()},
    receive
        {reply_from, Who} ->
            io:format("~w replied!~n", [Who])
    end.
