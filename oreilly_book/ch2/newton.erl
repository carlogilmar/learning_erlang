-module(newton).
-export([nth_root/2, raise/2]).

-spec(nth_root(number(), integer()) -> number()).

nth_root(X, N) ->
  io:format(" Step 1... \n"),
  A = X / 2.0,
  nth_root(X, N, A).

nth_root(X, N, A) ->
  io:format(" Step 2... \n"),
  io:format("Current guess is ~p~n", [A]), %% see the guesses converge
  F = raise(A, N) - X,
  Fprime = N * raise(A, N - 1),
  Next = A - F / Fprime,
  Change = abs(Next - A),
  if
    Change < 1.0e-8 -> Next;
    true -> nth_root(X, N, Next)
  end.

-spec(raise(number(), integer()) -> number()).

raise(_, 0) -> 1;

raise(X, N) when N > 0 ->
    raise(X, N, 1);

raise(X, N) when N < 0 -> 1 / raise(X, -N).

raise(_, 0, Accumulator) -> Accumulator;

raise(X, N, Accumulator) ->
    raise(X, N-1, X * Accumulator).
