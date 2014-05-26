-module(mutex).
-export([start/0, stop/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() ->
    register(mutex, spawn(?MODULE, init, [])),
    io:format("Mutex started~n").

stop() ->
    mutex ! stop,
    io:format("Mutex stopped, bye.~n").



% client

wait() ->
    io:format("Sending the event WAIT~n"),
    mutex ! {wait, self()},
    receive
        ok -> ok
    end.

signal() ->
    io:format("Sending the event SIGNAL~n"),
    mutex ! {signal, self()}.


% mutex

init() ->
    io:format("Initializing the mutex~n"),
    free().

free() ->
    io:format("Entered the state FREE~n"),
    receive
        {wait, Pid} ->
            Pid ! ok,
            busy(Pid);
        stop ->
            terminate()
    end.

busy(Pid) ->
    io:format("Entered the state BUSY~n"),
    receive
        {signal, Pid} ->
            free()
    end.


terminate() ->
    receive
        {wait, Pid} ->
            exit(Pid, kill),
            terminate()
   after
       0 -> ok
   end.
         
