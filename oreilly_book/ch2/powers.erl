-module(powers).
-export([raise/2, enter/2, raise_acc/2]).

-spec(raise(number(), integer()) -> number()).

raise(_, 0) -> 1;
raise(X, 1) -> X;
raise(X, N) when N > 0 -> X * raise(X, N-1);
raise(X, N) when N < 0 -> 1 / raise(X, -N).

enter(X, N) ->
  io:format("Enter X: ~p, N: ~p~n", [X, N]),
  io:format(":: Processing... ::"),
  X * raise(X, N - 1).

raise_acc(_, 0) -> 1;
raise_acc(X, N) when N > 0 -> raise_acc(X, N, 1);
raise_acc(X, N) when N < 0 -> 1 / raise_acc(X, -N).

raise_acc(_, 0, Acc) ->
  io:format("N is 0"),
  Result = Acc,
  io:format("Result is ~p~n", [Result]),
  Result;

raise_acc(X, N, Acc) ->
  io:format("Enter: X is ~p, N is ~p, Accumulator is ~p~n", [X, N, Acc]),
  Result = raise_acc(X, N-1, X * Acc),
  io:format("Result is ~p~n", [Result]),
  Result.







