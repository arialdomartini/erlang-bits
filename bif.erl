-module(bif).
-export([head/0]).

head() ->
    List = [one, two, three, four, five],
    hd(List).
