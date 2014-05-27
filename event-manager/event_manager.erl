-module(event_manager).
-export([start/2, stop/1]).
-export([add_handler/3, delete_handler/2, get_data/2, send_event/2]).
-export([init/1]).

start(Name, HandlerList) ->
    register(Name, spawn(?MODULE, init, [HandlerList])),
    ok.

init(HandlerList) ->
    loop(initialize(HandlerList)).

initialize([]) ->
    [];
initialize([{Handler, InitData} | Rest]) ->
    [ {Handler, Handler:init(InitData)} | initialize(Rest)].

stop(Name) ->
    Name ! {stop, self()},
    receive {reply, Reply} -> Reply end.

terminate([]) ->
    [];
terminate([{Handler, Data}|Rest]) ->
    [ {Handler, Handler:terminate(Data)} | terminate(Rest) ].



% client functions

add_handler(Name, Handler, InitData) ->
    call(Name, {add_handler, Handler, InitData}).

delete_handler(Name, Handler) ->
    call(Name, {delete_handler, Handler}).

get_data(Name, Handler) ->
    call(Name, {get_data, Handler}).
    
send_event(Name, Event) ->
    call(Name, {send_event, Event}).

call(Name, Message) ->
    Name ! {request, self(), Message},
    receive {reply, Reply} -> Reply end.


% Service functions
loop(State) ->
    receive
        {request, From, Message} ->
            {Reply, NewState} = handle_message(Message, State),
            reply(From, Reply),
            loop(NewState);
        {stop, From} ->
            reply(From, terminate(State))
    end.


reply(To, Message) ->
    To ! {reply, Message}.


handle_message({add_handler, Handler, InitData}, State) ->
    {ok, [{Handler, Handler:init(InitData)}|State]};

handle_message({delete_handler, Handler}, State) ->
    case lists:keysearch(Handler, 1, State ) of
        false ->
            {{error, notfound}, State};
        {value, {Handler, Data}} ->
            Reply = {Handler, Handler:terminate(Data)},
            NewState = lists:keydelete(Handler, 1, State),
            {Reply, NewState}
    end;

handle_message({get_data, Handler}, State) ->
    case lists:keysearch(Handler, 1, State) of
        false ->
            {{error, not_found}, State};
        {value, {Handler, Data}} -> {{data, Data}, State}
    end;

handle_message({send_event, Event}, State) ->
    {ok, event(Event, State)}.

event(_Event, []) ->
    [];
event(Event, [{Handler, Data}|Rest]) ->
    [{Handler, Handler:handle_event(Data)} | event(Event, Rest)].


