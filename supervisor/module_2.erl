-module(module_2).
-export([start/0, request/1, loop/0]).

start() ->
    Pid = spawn_link(?MODULE, loop, []),
    register(module_2, Pid),
    {ok, Pid}.

request(Int) ->
    module_2 ! {request, self(), Int},
    receive 
        {reply, Reply}         ->  Reply
    end.


loop() ->
    receive 
        {request, Pid, Int } -> 
            Pid ! {reply, Int + 2 }
    end,
    loop().
