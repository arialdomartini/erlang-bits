-module(mymnesia).
-export([run/0]).

run() ->
    mnesia:create_schema([node()|nodes()]),
    mnesia:start().
