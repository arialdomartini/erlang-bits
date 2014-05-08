-module(numbers).
-export([even/1, number/1]).

even(Int) when Int rem 2 == 0 -> even;
even(Int) when Int rem 2 == 1 -> odd.

number(Num) when is_integer(Num)  -> integer;
number(Num) when is_float(Num)    -> float;
number(_Other)                    -> false.
