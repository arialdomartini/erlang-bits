-module(add_two).
-export([start/0, request/1, loop/0]).

start() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(add_two, loop, []),
    register(add_two, Pid),
    {ok, Pid}.

request(Int) ->
    process_flag(trap_exit, true),
    add_two ! {request, self(), Int},
    receive 
        {reply, Reply}         ->  Reply;
        {'EXIT', _Pid, Reason} ->  {error, Reason}
    after 1000                 ->  timeout 
    end.


loop() ->
    receive 
        {request, Pid, Int } -> 
            Pid ! {reply, Int + 2 }
    end,
    loop().
