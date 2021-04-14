- module(stats).
- export([minimum/1]).

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
