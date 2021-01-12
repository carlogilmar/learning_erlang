-module(hello_world).
-export([hello_world/0]).
-include_lib("stdlib/include/qlc.hrl").
-include("company.hrl").

hello_world() ->
  io:format("Hello, World!~n", []).
