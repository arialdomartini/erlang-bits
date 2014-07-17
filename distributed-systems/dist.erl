-module(dist).
-export([remote_call/0, init/0, ping/0]).

init() ->
    loop().

loop() ->
    receive
        {message, From} ->  From ! {reply_from, node()}
    end,
    loop().

remote_call() ->
    net_kernel:start(["bar"]),
    Remote = spawn('bar@localhost', dist, init, []),
    Remote ! {message, self()},
    receive
        {reply_from, Who} ->
            io:format("~w replied!~n", [Who])
    end.


ping() ->
    io:format(">> Start an Erlang node with~n   erl -sname foo -setcookie cake~n"),
    erlang:set_cookie(node(), 'cake'),
    net_adm:ping('foo@macaco').
