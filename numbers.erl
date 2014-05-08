-module(numbers).
-export([even/1]).

even(Int) when Int rem 2 == 0 -> even;
even(Int) when Int rem 2 == 1 -> odd.
