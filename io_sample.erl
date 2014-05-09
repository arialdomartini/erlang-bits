-module(io_sample).
-export([read_line_from_standard_input/0]).

read_line_from_standard_input() ->
    io:get_line("what's your name, pal? :").