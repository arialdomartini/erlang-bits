-module(race_condition).
-export([start/0]).

start() ->
    case whereis(db_server) of
        undefined ->
            Pid = spawn(db_server, init, []),
            register(db_server, Pid),
            {ok, Pid};
        Pid when is_pid(Pid) ->
            {error, already_started}
    end.