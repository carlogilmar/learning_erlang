-module(calculus).
-export([derivative/2]).

%%% Anonymous function
%%% function A = fun() -> io:fwrite("Hello") end.
%%%  ------------------------------------------------------
%%%  calculus:derivative((fun(Item) -> Item + 10 end), 1.23).

-spec(derivative(function(), float()) -> float()).
derivative(Fn, X) ->
  Delta = 1.0e-10,
  (Fn(X + Delta) - Fn(X)) / Delta.
