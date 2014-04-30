-module(listhelpers).
-export([listlen/1, listlen_case/1]).


% Calculates the length of a list using tail recursion and pattern matching
listlen([])         -> 0;
listlen([_|Xs])     -> 1 + listlen(Xs).

% Calculates the length of a list using tail recursion and a case expression
listlen_case(Y) ->
    case Y of
        []          -> 0;
        [_|Xs]      -> 1 + listlen_case(Xs)
    end.