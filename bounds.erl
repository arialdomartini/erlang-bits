-module(bounds).
-export([safe/1]).

safe(X) ->
    case X of
        1 -> Y=12;
        _   -> Y= 196
    end,
    X + Y.
