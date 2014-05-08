-module(if_constructor).
-export([evaluate/1]).

evaluate(Number) ->
    if
        Number < 0 -> negative;
        Number > 0 -> positive;
        Number == 0 -> zero
    end.