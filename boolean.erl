-module(boolean).
-export([b_not/1, b_and/2]).

b_not(true) ->
    false;
b_not(false) ->
    true;
b_not(_Object) ->
    {error, "object must be either true or false"}.

b_and(false, _) ->
    false;
b_and(_, false) ->
    false;
b_and(true, true) ->
    true;
b_and(_,_) ->
    {error, "arguments must be true or false"}.