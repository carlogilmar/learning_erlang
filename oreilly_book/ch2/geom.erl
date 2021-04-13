-module(geom).
-export([area/2, get_area/3, validate_area/1, get_message/1]).

%% Include specs
-spec(area(number(), number()) -> number()).
area(L,W) -> L * W.

-spec(get_area(atom(), number(), number()) -> number()).

get_area(rectangle, L, W) -> L * W;
get_area(triangle, L, W) -> (L * W) / 2.0;
get_area(ellipse, A, B) -> math:pi() * A * B.

-spec(validate_area(atom(), number(), number()) -> number()).
%% Using guards
validate_area(rectangle, A, B) when A >= 0, B >=0 -> A*B;
validate_area(triangle, A, B) when A >= 0, B >=0 -> A*B;
validate_area(ellipse, A, B) when A >= 0, B >=0 -> A*B;
%% Pattern Matching
validate_area(_,_,_) -> no_hay_papito.

%% Functions with arity
%% Note: Only this function is public
-spec(validate_area({atom(), number(), number()}) -> number()).
validate_area({Shape, Dim1, Dim2}) -> validate_area(Shape, Dim1, Dim2).

-spec(get_message(number()) -> atom()).
get_message(Shape) when Shape > 0 ->
  case Shape of
    1 -> es_uno;
    2 -> es_dos;
    3 -> es_tres;
    _ -> es_otro
  end.
