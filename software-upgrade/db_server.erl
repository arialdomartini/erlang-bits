-module(db_server).
-export([start/0, stop/0, upgrade/1]).
-export([write/2, read/1, delete/1]).
-export([init/0, loop/1]).
-vsn(1.0).

% Process management
start() ->
    register(db_server, spawn(db_server, init, [])).

stop() ->
    db_server ! stop.

% Server

init() ->
    loop(db:new()).

loop(Db) ->
    receive
        {ugrade, Data} -> 
            NewDb = db:convert(Data, Db),
            db_server:loop(NewDb);
        {write, Key, Data} -> 
            loop(db:write(Key, Data, Db));
        {read, Pid, Key} -> 
            Read = db:read(Key, Db),
            Pid ! Read,
            loop(Db);
        {delete, Key} ->
            NewDb = db:delete(Key, Db),
            loop(NewDb);
        {stop} -> db:destroy(Db)
    end.

% Client API

upgrade(Data) ->
    db_server ! {upgrade, Data}.

write(Key, Data) ->
    db_server ! {write, Key, Data}.

read(Key) ->
    db_server ! {read, self(), Key},
    receive Reply -> Reply end.

delete(Key) ->
    db_server ! {delete, Key}.


