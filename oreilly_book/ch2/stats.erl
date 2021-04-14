- module(stats).
- export([minimum/1, maximum/1, range/1]).

-spec(minimum(list(number())) -> number()).

%%% Return the min number of a given list

minimum(NumberList) ->
  [Result | Rest] = NumberList,
  minimum(Rest, Result).

minimum([], Result) -> Result;

minimum([Head|Tail], Result) ->
  case Head < Result of
    true -> minimum(Tail, Head);
    false -> minimum(Tail, Result)
  end.

%%% Return the max number of a given list

-spec(maximum(list(number())) -> number()).

maximum(NumberList) ->
  [Result | Rest] = NumberList,
  maximum(Rest, Result).

maximum([], Result) -> Result;

maximum([Head|Tail], Result) ->
  case Head > Result of
    true -> maximum(Tail, Head);
    false -> maximum(Tail, Result)
  end.

%% Range

-spec(range([number()]) -> [number()]).
range(NumberList) -> [minimum(NumberList), maximum(NumberList)].



