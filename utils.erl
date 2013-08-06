-module(utils).
-export([wc/1]).
-export([wc/2]).

wc(Words) -> wc(0, Words).
wc(Len, []) -> Len;
wc(Len, Words) -> wc(Len+1, erlang:tl(Words)).


