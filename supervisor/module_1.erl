-module(module_1).
-export([start/0, request/1, loop/0]).

start() ->
    Pid = spawn_link(?MODULE, loop, []),
    register(module_1, Pid),
    {ok, Pid}.

request(Int) ->
    module_1 ! {request, self(), Int},
    receive 
        {reply, Reply}         ->  Reply
    end.


loop() ->
    receive 
        {request, Pid, Int } -> 
            Pid ! {reply, Int + 1 }
    end,
    loop().
