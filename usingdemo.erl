-module(usingdemo).
-export([usedemo/1]).

usedemo(Value) ->
    demo:double(Value).
