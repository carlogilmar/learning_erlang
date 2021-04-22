-module(cards).
-export([make_deck/0, shuffle/1]).

make_deck() ->
  [
   {Value, Suit} ||
   Value <- ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
   Suit <- ["Clubs", "Diamonds", "Hearts", "Spades"]
  ].

shuffle(List) -> shuffle(List, []).
shuffle([], Acc) -> Acc;

shuffle(List, Acc) ->
  {Leading, [Head_elem|Tail]} = lists:split(rand:uniform(length(List)) - 1, List),
  shuffle(Leading++Tail, [Head_elem|Acc]).
