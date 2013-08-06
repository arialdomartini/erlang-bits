-module(utils).
-export([wc/1]).
-export([wc/2]).
-export([count/0]).
-export([count/2]).

wc(Words) -> wc(0, Words).
wc(Len, []) -> Len;
wc(Len, Words) -> wc(Len+1, erlang:tl(Words)).

count() -> count(1,[1]).
count(10, S)->S;
count(L, S) -> count(L+1, lists:append(S, [erlang:length(S)+1])).
