-module(ask_area).
-export([area/0]).

-spec(area() -> number()).

area() ->
  Answer = io:get_line("R)ectangle, T)riangle, or E)llipse > "),
  Shape = char_to_shape(hd(Answer)),
  case Shape of
    rectangle -> Numbers = get_dimensions("width", "height");
    triangle -> Numbers = get_dimensions("base", "height");
    ellipse -> Numbers = get_dimensions("major axis", "minor axis");
    unknown -> Numbers = {error, "Unknown shape" ++ [hd(Answer)]}
  end,
  Area = calculate(Shape, element(1, Numbers), element(2, Numbers)),
  Area.

-spec(char_to_shape(char()) -> atom()).
char_to_shape(Char) ->
  case Char of
    $R -> rectangle;
    $r -> rectangle;
    $T -> triangle;
    $t -> triangle;
    $E -> ellipse;
    $e -> ellipse;
    _ -> unknown;
  end.

-spec(get_number(string()) -> number()).
get_number(Prompt) ->
  Str = io:get_line("Enter "++ Prompt ++ " > "),
  {Test, _} = string:to_float(Str),
  case Test of
    error -> {N, _} = string:to_integer(Str);
    _ -> N = Test
  end,
  N.


