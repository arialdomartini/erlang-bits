-module(bif).
-export([head/0, tail/0]).

head() ->
    List = [one, two, three, four, five],
    hd(List).

tail() ->
    List = [one, two, three, four, five],
    tl(List).