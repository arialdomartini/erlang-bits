-module(boolean).
-export([b_not/1]).

b_not(true) ->
    false;
b_not(false) ->
    true;
b_not(_Object) ->
    {error, "object must be either true or false"}.