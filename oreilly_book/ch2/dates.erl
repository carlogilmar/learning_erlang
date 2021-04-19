-module(dates).
-export([date_parts/1, julian/1, is_leap_year/1]).

-spec(date_parts(string()) -> list()).

date_parts(DateStr) ->
  [YStr, MStr, DStr] = re:split(DateStr, "-", [{return, list}]),
  [element(1, string:to_integer(YStr)),
   element(1, string:to_integer(MStr)),
   element(1, string:to_integer(DStr))].

% Returns the index of that date in the year
-spec(julian(string()) -> integer()).
julian(IsoDate) ->
  DaysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
  [Y, M, D] = date_parts(IsoDate),
  julian(Y, M, D, DaysPerMonth, 0).

-spec(julian(integer(), integer(), integer(), [integer()], integer()) -> integer()).
julian(Y, M, D, MonthList, Total) when M > 13 - length(MonthList) ->
  [ThisMonth|TailMonths] = MonthList,
  julian(Y, M, D, TailMonths, Total + ThisMonth);

julian(Y, M, D, _MonthList, Total) ->
  case M > 2 andalso is_leap_year(Y) of
    true -> Total + D + 1;
    false -> Total + D
  end.

-spec(is_leap_year(integer()) -> boolean()).
is_leap_year(Year) ->
  (Year rem 4 == 0 andalso Year rem 100 /= 0)
  orelse (Year rem 400 == 0).

