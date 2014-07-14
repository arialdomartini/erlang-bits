-module(ets_tables).
-export([info/0, insert_lookup/0]).


info() ->
    Set = ets:new(sample, []),
    Info = ets:info(Set),
    ets:delete(Set),
    Info.

insert_lookup() ->
    Set = ets:new(my_set, [named_table]),
    ets:insert(Set, {key, value}),
    Value = ets:lookup(Set, key),
    io:format("At key ~w the set stored the value ~w~n", [key, Value]).
