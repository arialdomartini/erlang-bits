-module(macros).
-export([start/0, send/1]).
-export([init/0]).
-export([double/1, is_multiple/2]).

-define(TIMEOUT, 2500).
-define(FUNC, X).
-define(TION, +X).

-define(MULTIPLE(X, Y), X rem Y == 0).

double(X) ->
    ?FUNC?TION.

is_multiple(A, B) when ?MULTIPLE(A,B) ->
    true;
is_multiple(_A, _B) ->
    false.

start() ->
    process_flag(trap_exit, true),
    register(macros, spawn(?MODULE, init, [])),
    link(whereis(macros)),
    io:format("Process started with PID~p~nYou have ~p seconds to run send(N)~n", [whereis(macros), ?TIMEOUT/1000]),
    ok.

send(Number) ->
    macros ! {request, self(), Number},
    receive
        {reply, Reply} ->
            Reply;
        {'EXIT', _Pid, Reason} ->  
            {error, Reason}
    end.

init() ->
    loop().

loop() ->
    receive
        {request, Pid, N} ->
            reply(Pid, {ok, N+1}),
            loop()
    after ?TIMEOUT ->
            io:format("Timeout. I'm quitting"),
            {error, timeout}
    end.

reply(Pid, Message) ->
    Pid ! {reply, Message}.
