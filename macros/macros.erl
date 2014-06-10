-module(macros).
-export([start/0, send/1, list_all_macros/0]).
-export([init/0]).
-export([double/1, is_multiple/2]).

-define(TIMEOUT, 2500).
-define(FUNC, X).
-define(TION, +X).

-define(MULTIPLE(X, Y), X rem Y == 0).

% you can activate and disable debugging by compiling this module with
% c(macros, [{d, debug}]). % enable
% c(macros, [{u, debug}]). % disable
-ifdef(debug).
    -define(DBG(Str, Args), io:format(Str, Args)).
-else.
    -define(DBG(Str, Args), ok).
-endif.

-define(VALUE(Call), io:format("~p = ~p~n", [??Call, Call])).

double(X) ->
    ?FUNC?TION.

is_multiple(A, B) when ?MULTIPLE(A,B) ->
    ?DBG("Got these values: ~p and ~p~n", [A, B]),
    ?VALUE(length([1,2,3])),
    true;
is_multiple(A, B) ->
    ?DBG("Got these values: ~p and ~p~n", [A, B]),
    false.

list_all_macros() ->
    io:format("?MODULE: ~p~n?MODULE_STRING: ~p~n?FILE: ~p~n?LINE: ~p~n?MACHINE: ~p~n", [?MODULE, ?MODULE_STRING, ?FILE, ?LINE, ?MACHINE]).

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
