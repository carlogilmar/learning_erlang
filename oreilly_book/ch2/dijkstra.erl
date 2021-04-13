-module(dijkstra).
-export([gcd/2, gcd2/2]).

%% Calculate gcd Greatest common divisor of two integers

-spec(gcd(number(), number()) -> number()).
gcd(M, N) ->
  if
    M == N  -> M;
    M > N -> gcd(M - N, N);
    true -> gcd(M, N - M)
  end.

-spec(gcd2(number(), number()) -> number()).
gcd2(M, N) when M == N -> M;
gcd2(M, N) when M > N -> gcd2(M - N, N);
gcd2(M, N) -> gcd2(M, N - M).
