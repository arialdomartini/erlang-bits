-module(ets_tables).
-export([info/0, set_insert_lookup/0, bag_insert_lookup/0]).


info() ->
    Set = ets:new(sample, []),
    Info = ets:info(Set),
    ets:delete(Set),
    Info.

set_insert_lookup() ->
    Set = ets:new(my_set, [named_table]),
    ets:insert(Set, {key, value}),
    ets:insert(Set, {key, bar}),
    Value = ets:lookup(Set, key),
    io:format("At key ~w the set stored only the last value ~w~n", [key, Value]).

bag_insert_lookup() ->
    Bag = ets:new(my_bag, [bag]),
    ets:insert(Bag, {foo, bar}),
    ets:insert(Bag, {foo, baz}),
    Values = ets:lookup(Bag, foo),
    io:format("At key ~w the bag stored both the balues: ~w", [foo, Values]). 
