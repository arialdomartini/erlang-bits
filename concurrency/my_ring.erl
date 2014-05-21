-module(my_ring).
-export([start/1, start_proc/2]).

start(Num) ->
    start_proc(Num, self()).


start_proc(Num, Pid) when Num > 0 ->
    NPid = spawn(my_ring, start_proc, [Num-1, Pid]),
    NPid ! ok,
    receive
        ok -> ok
    end;

start_proc(0, Pid) ->
    Pid ! ok.
