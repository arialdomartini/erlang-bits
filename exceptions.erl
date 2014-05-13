-module (exceptions).
-export([sample/0, throw_sample/0]).

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