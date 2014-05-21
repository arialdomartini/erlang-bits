-module(my_timer).
-export([send_after/2, send/3, do/0]).

send_after(Time, Message) ->
    spawn(my_timer, send, [self(), Time, Message]),
    receive
        {write, Message} -> {received, Message}
    end.
send(Pid, Time, Message) ->
    receive
    after
        Time -> Pid ! {write, Message}
    end.

do() ->
    done.