-module(skeleton).
-export([start/2, stop/1, call/2]).
-export([init/1]).

start(Name, Data) ->
    Pid = spawn(?MODULE, init, [Data]),
    register(Name, Pid).

stop(Name) ->
    Name ! {stop, self()},
    receive
        {reply, Reply} ->
             Reply
    end.

call(Name, Message) ->
    Name ! {request, self(), Message},
    receive
        {reply, Reply} ->
            Reply
    end.

init(Data) ->
    loop(initialize(Data)).

initialize(Data) ->
    State = Data,
    State.

loop(State) ->
    receive
        {request, From, Message } ->
            {Reply, NewState} = handle_request(Message, State),
            reply(From, Reply),
            loop(NewState);
        {stop, From} ->
            reply(From, terminate(State))
    end.

reply(From, ReplyMessage) ->
    From ! {reply, ReplyMessage}.

terminate(State) ->
    {terminating, State}.

handle_request(Message, State) ->
    NewState = State + 1,
    Reply = {calculated_reply, Message + NewState},
    {Reply, NewState}.
