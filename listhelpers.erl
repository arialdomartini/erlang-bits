-module(listhelpers).
-export([listlen/1]).


% Calculates the length of a list using tail recursion
listlen([])         -> 0;
listlen([_|Xs])     -> 1 + listlen(Xs).