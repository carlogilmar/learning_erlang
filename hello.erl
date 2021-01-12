-module(hello).
-export([hello_world/0]).
%% er_user is the name of record
-record(er_user, {
  username :: binary(),    % username is a binary field
  password :: binary()     % password is a binary field
}).    % Erlang statement ends with dot

hello_world() ->
  io:format("Hello, World!~n", []).
