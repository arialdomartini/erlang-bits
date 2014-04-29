-module(importingdemo).
-import(demo, [double/1]).
-export([run/1, get_info_about_demo/0]).

run(Value) ->
    double(Value).

get_info_about_demo() ->
  demo:module_info().