-module(bif).
-export([head/0, tail/0, length/0, second_item/0]).

head() ->
    List = [one, two, three, four, five],
    hd(List).

tail() ->
    List = [one, two, three, four, five],
    tl(List).

length() ->
    List = [one, two, three, found, five],
    length(List).

second_item() ->
    List = [one, two, three, found, five],
    hd(tl(List)).