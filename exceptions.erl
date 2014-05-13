-module (exceptions).
-export([sample/0]).

sample() ->
    X = 2,
    try (X=3) of
        Val -> Val
    catch
        error:ErrorMessage -> {error, ErrorMessage}
    end.