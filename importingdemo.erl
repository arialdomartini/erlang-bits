-module(importingdemo).
-import(demo, [double/1]).
-export([run/1]).

run(Value) ->
    double(Value).