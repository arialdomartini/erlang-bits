-module(metaprogramming).
-export([apply/0]).

apply() ->
    Module = numbers,
    Function = even,
    Arguments = [10],
    apply(Module, Function, Arguments).