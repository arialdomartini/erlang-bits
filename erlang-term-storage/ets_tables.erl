-module(ets_tables).
-export([run/0]).


run() ->
    Set = ets:new(sample, []),
    ets:info(Set).
