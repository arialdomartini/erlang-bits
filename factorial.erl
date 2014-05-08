-module(factorial).
-export([classic/1, with_guard/1]).

classic(0) -> 1;
classic(N)  -> N * classic(N-1).


with_guard(N) when N > 0 -> 
    N * with_guard(N-1);
with_guard(0) -> 1.
