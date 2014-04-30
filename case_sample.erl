-module(case_sample).
-export([contains_a/1, convert_day/1]).

contains_a(List) ->
    case lists:member(a, List) of
        true -> "The list contains the atom a";
        false -> "I'm sorry, the list does not contains the atom a"
    end.


% An example of Defensive Programming. This is a bad practice.
convert_day(Day) ->
    case Day of
        monday      -> 1;
        tuesday     -> 2;
        wednesday   -> 3;
        thursday    -> 4;
        friday      -> 5;
        saturday    -> 6;
        sunday      -> 7;
        Other       -> {error, unknown_day}
    end.