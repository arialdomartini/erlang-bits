-module(path).
-export([main/0]).

main() ->
    io:format("code:get_path(): ~p~n", [code:get_path()]),
    io:format("code:root_dir(): ~p~n", [code:root_dir()]).
