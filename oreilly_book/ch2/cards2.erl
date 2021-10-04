-module(cards2).
-export([make_deck/0, shuffle/1]).

-type card()::{string()|integer(), string()}.

-spec(make_deck() -> [card()]).
make_deck() ->
  [{Value, Suit} || Value <- ["A", 2, 3, 4],
    Suit <- ["Clubs", "Diamonds"]].

-spec(shuffle([card()])-> [card()]).
shuffle(List) -> shuffle(List, []).
shuffle([], Acc) -> Acc;
shuffle(List, Acc) ->
  {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
  shuffle(Leading ++ T, [H | Acc]).
