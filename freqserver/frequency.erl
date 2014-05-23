-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

start() ->
    io:format("Starting~n"),
    register(frequency, spawn(?MODULE, init, [])).

init() ->
    Frequencies = {get_frequencies(), []}, % { Available, Allocated }
    loop(Frequencies).

get_frequencies() -> 
    io:format("Getting frequencies~n"),
    [10, 11, 12, 13, 14, 15].


stop() -> call(stop).
allocate() -> call(allocate).
deallocate(Freq) -> call({deallocate, Freq}).

call(Message) ->
    frequency ! {request, self(), Message},
    receive
        {reply, Reply} -> Reply
    end.


loop(Frequencies) ->
    receive
        {request, Pid, stop} -> 
            io:format("Invoking stop~n"),
            reply(Pid, ok);

        {request, Pid, allocate} -> 
            io:format("Invoking allocate~n"),
            {NewFrequencies, Reply} = allocate(Frequencies, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);

        {request, Pid, {deallocate, Freq}} -> 
            io:format("Invoking deallocate~n"),
            NewFrequencies = deallocate(Frequencies, Freq),
            reply(Pid, ok),
            loop(NewFrequencies)
    end.

reply(Pid, Reply) ->
    Pid ! {reply, Reply}.


allocate( { [], Allocated  }, _Pid  ) ->
    io:format("No frequency~n"),
    { { [], Allocated } , {error, no_frequency} };
allocate( {[Freq|Available], Allocated }, Pid ) ->
    io:format("Frequency found~n"),
    { {Available, [{Freq, Pid} | Allocated]}, {ok, Freq} }.


deallocate({Available, Allocated}, Freq) ->
    io:format("Deallocating~n"),
    NewAllocated = lists:keydelete(Freq, 1, Allocated),
    {[Freq|Available], NewAllocated }.
