-module (exceptions).
-export([sample/0, throw_sample/0, return/1, add/2]).

sample() ->
    X = 2,
    try (X=3) of
        Val -> Val
    catch
        error:ErrorMessage -> {error, ErrorMessage}
    end.

throw_sample() ->
    try( throw(an_error) ) of
        Val -> { no_error, Val}
    catch
        throw:Error -> {throw, Error}
    end.

return_error_X(X) when X < 0 ->
    % the format is {'EXIT', {Reason, Stack}}
    throw({'EXIT', something});

return_error_X(X) when X == 0 ->
    1/X;
return_error_X(X) when X > 0 ->
    {'EXIT', {badarity, [{doo}]}}.

return(X) when is_integer(X) ->
    try return_error_X(X) of
        Val -> {normal, Val}
    catch
        exit:Reason  -> {exit, Reason};
        throw:Throw -> {throw, Throw};
        error:Error -> {error, Error}
    end.

add(X, Y) -> 
    test_int(X),
    test_int(Y),
    X + Y.

test_int(Int) when is_integer(Int) -> true;
test_int(X) -> throw({error, {not_integer, X}}).