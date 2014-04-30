-module(case_sample).
-export([contains_a/1]).

contains_a(List) ->
    case lists:member(a, List) of
        true -> "The list contains the atom a";
        false -> "I'm sorry, the list does not contains the atom a"
    end.