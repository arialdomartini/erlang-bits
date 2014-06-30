-module(db).
-export([new/0, write/3, read/2, delete/2, destroy/1, convert/2]).
-export([test/0, info/0]).
-vsn(1.3).

new() ->
    gb_trees:empty().

write(Key, Data, Db) ->
    gb_trees:insert(Key, Data, Db).

read(Key, Db) ->
    case gb_trees:lookup(Key, Db) of
        none -> {error, instance};
        {valye, Data} -> {ok, Data}
    end.

delete(Key, Db) ->
    gb_trees:delete(Key, Db).

destroy(_Db) ->
    {ok, "Not yet implemented"}.

convert(dict, Dict) ->
    dict(dict:fetch_keys(Dict), Dict, new());
convert(_, Data) ->
    Data.

dict([Key|Tail], Dict, GbTree) ->
    Data = dict:fetch(Key, Dict),
    NewGbTree = gb_trees:insert(Key, Data, GbTree),
    dict(Tail, Dict, NewGbTree);
dict([], _, GbTree) ->
    GbTree.

test() ->
        io:format("call this function as Db2 = db:test().~n"),
    Db = db:new(),
    Db1 = db:write(kent, beck, Db),
    Db2 = db:write(joe, armstrong, Db1),
    io:format("Get this value and perform a db:read(kent, Db2)~n"),
    
    Db2.

info() ->
    db:module_info().
