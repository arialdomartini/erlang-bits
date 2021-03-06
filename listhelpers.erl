-module(listhelpers).
-export([listlen/1, listlen_case/1, index/2, index_case/2, index_nested_case/2]).

% Calculates the length of a list using tail recursion and pattern matching
listlen([])         -> 0;
listlen([_|Xs])     -> 1 + listlen(Xs).

% Calculates the length of a list using tail recursion and a case expression
listlen_case(Y) ->
    case Y of
        []          -> 0;
        [_|Xs]      -> 1 + listlen_case(Xs)
    end.

% Returns the item at the index specified in a list
index(N, [_|Xs]) when N>0   -> index(N-1, Xs);
index(0, [X, _])            -> X.

% Returns the item at the index specified in a list using a case expression
index_case(Index, List) -> index_case({Index,List}).

index_case(Z) ->
    case Z of
        {0, [X|_]}      -> X;
        {N, [_|Xs]}    -> index_case(N-1, Xs)
    end.

index_nested_case(Index, List) ->
    case Index of
        0 ->
            case List of
                [Z|_]   -> Z
            end;
        N when N > 0 ->
            case List of
                [_|Zs]  -> index_nested_case(N-1, Zs)
            end
    end.
            
            