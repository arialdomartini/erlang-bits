-module(facserver).
-export([server/0]).
-export([loop/0]).

server() ->
    register(facserver, self()),
    loop().

loop() ->
    receive
        {Pid, Number} ->
            Pid ! {ok, factorial(Number)}
    end,
    loop().


    
