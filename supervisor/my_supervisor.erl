-module(my_supervisor).
-export([start_link/2, stop/1]).
-export([init/1]).

start_link(Name, ChildSpecList) ->
    register(Name, spawn_link(?MODULE, init, [ChildSpecList])),
    ok.

stop(Name) ->
    Name ! {stop, self()},
    receive
        {reply, Reply} ->
            Reply
    end.


init(ChildSpecList) ->
    process_flag(trap_exit, true),
    loop(start_children(ChildSpecList)).

start_children([]) ->
    io:format("No more children to start~n"),
    [];
start_children( [ {Module,Function,Arguments} | Rest ] ) ->
    io:format("I'm starting the child ~p", [{Module,Function,Arguments}]),
    case (catch apply(Module,Function,Arguments)) of
        {ok, Pid} ->
            io:format("ok, it started!~n"),
            [{Pid, {Module,Function,Arguments}} | start_children(Rest)];
        Other ->
            io:format("Oh, no! It didn't start!~n"),
            io:format("It returned ~p~n", [Other]),
            start_children(Rest)
    end.

loop(ChildList) ->
    receive
        {'EXIT', Pid, _Reason} -> 
            NewChildList = restart_child(Pid, ChildList),
            loop(NewChildList);
        {stop, From} ->
            Reply = terminate(ChildList),
            From ! {reply, Reply}
    end.

restart_child(Pid, ChildList) ->
    io:format("This is the current content of ChildList: ~p~n", [ChildList]),
    {value, Found} = lists:keysearch(Pid, 1, ChildList),
    {Pid, {Module, Function, Arguments}} = Found,
    {ok, NewPid} = apply(Module, Function, Arguments),
    ChildListWithoutDeadChild = lists:keydelete(Pid, 1, ChildList),
    [ {NewPid, {Module, Function, Arguments}} | ChildListWithoutDeadChild ].


terminate([{Pid, _} | ChildList]) ->
    exit(Pid, kill),
    terminate(ChildList);
terminate([]) -> ok.

