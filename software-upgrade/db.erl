-module(db).
-export([new/0, write/3, read/2, delete/2, destroy/1]).
-export([test/0, info/0]).
-vsn(1.2).

new() ->
    dict:new().

write(Key, Data, Db) ->
    dict:store(Key, Data, Db).

read(Key, Db) ->
    case dict:find(Key, Db) of
        error -> {error, instance};
        {ok, Data} -> {ok, Data}
    end.

delete(Key, Db) ->
    dict:erase(Key, Db).

destroy(_Db) ->
    {ok, "Not yet implemented"}.


test() ->
        io:format("call this function as Db2 = db:test().~n"),
    Db = db:new(),
    Db1 = db:write(kent, beck, Db),
    Db2 = db:write(joe, armstrong, Db1),
    io:format("Get this value and perform a db:read(kent, Db2)~n"),
    
    Db2.

info() ->
    db:module_info().
