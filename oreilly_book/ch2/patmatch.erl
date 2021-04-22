-module(patmatch).
-export([get_people/0, older_males/0, older_or_male/0]).

get_people() ->
  [{"Federico", $M, 22}, {"Kim", $F, 45}, {"Hansa", $F, 30},
   {"Vu", $M, 47}, {"Cathy", $F, 32}, {"Elias", $M, 50}].

%% Comprehensions
older_males() ->
  People = get_people(),
  [Name || {Name, Gender, Age} <- People, Gender == $M, Age > 40].

older_or_male() ->
  People = get_people(),
  [Name || {Name, Gender, Age} <- People, (Gender == $M) orelse (Age > 40)].
