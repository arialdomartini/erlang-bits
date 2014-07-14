-module(ets_tables).
-export([run/0]).


run() ->
    Set = ets:new(sample, []),
    Info = ets:info(Set),
    ets:delete(Set),
    Info.
