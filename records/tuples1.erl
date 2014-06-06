-module(tuples1).
-export([test1/0, test2/0]).

test1() ->
    showPerson(joe()).

test2() ->
    showPerson(birthday(joe())).

joe() ->
    {"Joe", 21, "0573-278271"}.

birthday({Name, Age, Phone}) ->
    {Name, Age+1, Phone}.

showPerson({Name, Age, Phone}) ->
    io:format("name: ~p, age: ~p, phone: ~p", [Name, Age, Phone]).

