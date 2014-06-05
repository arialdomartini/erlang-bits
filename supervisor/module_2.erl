-module(module_2).
-export([start/0, request/1, loop/0]).

start() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, loop, []),
    register(add_one, Pid),
    {ok, Pid}.

request(Int) ->
    process_flag(trap_exit, true),
    add_one ! {request, self(), Int},
    receive 
        {reply, Reply}         ->  Reply;
        {'EXIT', _Pid, Reason} ->  {error, Reason}
    after 1000                 ->  timeout 
    end.


loop() ->
    receive 
        {request, Pid, Int } -> 
            Pid ! {reply, Int + 1 }
    end,
    loop().
