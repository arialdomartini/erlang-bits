-module(utils).
-export([wc/1]).
-export([wc/2]).
-export([count/0]).
-export([count/2]).
-export([positive/1]).
-export([countdown/0]).

wc(Words) -> wc(0, Words).
wc(Len, []) -> Len;
wc(Len, Words) -> wc(Len+1, erlang:tl(Words)).

count() -> count(1,[1]).
count(10, S)->S;
count(L, S) -> count(L+1, lists:append(S, [erlang:length(S)+1])).

positive(N) ->
  if 
    N > 0 ->
      "positive";
    N < 0 ->
      "negative";
    true ->
      "other"
  end.


kindly_announce(Message) -> io:format("Ladies and gentlemen.... ~p~n", [Message]).

countdown() ->
  lists:foreach(fun(I) -> kindly_announce(I) end, [10,9,8,7,6,5,4,3,2,1,"Go!"]).

