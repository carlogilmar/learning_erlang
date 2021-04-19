-module(teeth).
-export([alert/1]).

-spec(alert([integer()]) -> [integer()]).
alert(ToothList) -> alert(ToothList, 1, []).

alert([], _Tooth_number, Result) -> list:reverse(Result);

alert([Head|Tail], ToothNumber, Result) ->
  case stats:maximum(Head) >= 4 of
    true -> alert(Tail, ToothNumber + 1, [ToothNumber | Result]);
    false -> alert(Tail, ToothNumber + 1, Result)
  end.
