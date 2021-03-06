-module(ask_area).
-export([area/0]).

-spec(area() -> number()).

area() ->
  io:format(" Step 1, choose your shape... \n"),
  Answer = io:get_line("R)ectangle, T)riangle, or E)llipse > "),
  io:format(" Step 2, chart_to_shape/1 \n"),
  Shape = char_to_shape(hd(Answer)),
  case Shape of
    rectangle -> Numbers = get_dimensions("width", "height");
    triangle -> Numbers = get_dimensions("base", "height");
    ellipse -> Numbers = get_dimensions("major axis", "minor axis");
    unknown -> Numbers = {error, "Unknown shape" ++ [hd(Answer)]}
  end,
  io:format(" Data ready!  \n"),
  Area = calculate(Shape, element(1, Numbers), element(2, Numbers)),
  Area.

-spec(char_to_shape(char()) -> atom()).
char_to_shape(Char) ->
  io:format(" chart_to_shape/1 Getting atom by shape selected \n"),
  case Char of
    $R -> rectangle;
    $r -> rectangle;
    $T -> triangle;
    $t -> triangle;
    $E -> ellipse;
    $e -> ellipse;
    _ -> unknown
  end.

-spec(get_number(string()) -> number()).
get_number(Prompt) ->
  io:format(" get_number/1  \n"),
  Str = io:get_line("Enter "++ Prompt ++ " > "),
  {Test, _} = string:to_float(Str),
  case Test of
    error -> {N, _} = string:to_integer(Str);
    _ -> N = Test
  end,
  N.

-spec(get_dimensions(string(), string()) -> {number(), number()}).
get_dimensions(Prompt1, Prompt2) ->
  io:format(" get_dimensions/2  \n"),
  N1 = get_number(Prompt1),
  N2 = get_number(Prompt2),
  {N1, N2}.

-spec(calculate(atom(), number(), number()) -> number()).
calculate(unknown, _, Err) -> io:format("~s~n", [Err]);
calculate(_, error, _) -> io:format("Error in first number.~n");
calculate(_, _, error) -> io:format("Error in second number.~n");
calculate(_, A, B) when A < 0; B < 0 ->
  io:format("Both numbers must be greater than or equal to zero~n");
calculate(Shape, A, B) -> geom:get_area(Shape, A, B).

