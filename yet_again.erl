-module(yet_again).
-export([factorial/1]).
-export([fibonacci/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

fibonacci(0) -> 1;
fibonacci(1) -> 1;
fibonacci(N) -> fibonacci(N-1) + fibonacci(N-2).