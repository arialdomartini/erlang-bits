-define(TIMEOUT, 2500).
-define(FUNC, X).
-define(TION, +X).

-define(MULTIPLE(X, Y), X rem Y == 0).

% you can activate and disable debugging by compiling this module with
% c(macros, [{d, debug}]). % enable
% c(macros, [{u, debug}]). % disable
-ifdef(debug).
    -define(DBG(Str, Args), io:format(Str, Args)).
-else.
    -define(DBG(Str, Args), ok).
-endif.
