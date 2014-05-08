-module(if_constructor).
-export([evaluate/1, with_catch_all_guard/1]).

evaluate(Number) ->
    if
        Number < 0  -> negative;
        Number > 0  -> positive;
        Number == 0 -> zero
    end.

with_catch_all_guard(Number) ->
    if
        Number > 100    -> big;
        Number < 100   -> small;
        true            -> all_the_rest
    end.