-module(factorial).
-export([classic/1]).

classic(0) -> 1;
classic(N)  -> N * classic(N-1).
    