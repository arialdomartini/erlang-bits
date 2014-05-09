-module(io_sample).
-export([read_line_from_standard_input/0, write/0, format/0]).

read_line_from_standard_input() ->
    io:get_line("what's your name, pal? :").

write() ->
    io:write("Hello, world!").

format() ->
    List = [5, 6, 1, 22],
    Sum = lists:sum(List),
    io:format("The sum of the list ~w is ~w~n", [List, Sum]).