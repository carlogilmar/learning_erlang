-module(dates).
-export([date_parts/1]).

-spec(date_parts(string()) -> list()).

date_parts(DateStr) ->
  [YStr, MStr, DStr] = re:split(DateStr, "-", [{return, list}]),
  [element(1, string:to_integer(YStr)),
   element(1, string:to_integer(MStr)),
   element(1, string:to_integer(DStr))].
