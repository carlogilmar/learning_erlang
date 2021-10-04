-module(pingpong).
-export([pingpong/0]).

pingpong() ->
  receive
    {To, start} ->
      io:format("Starting Game! ~n"),
      io:format("Estoy en ~p~n", [self()]),
      io:format("Enviando a ~p~n", [To]),
      To ! {self(), pong},
      pingpong();
    {From, pong} ->
      io:format("Ping! ~n"),
      From ! {self(), ping},
      pingpong();
    {From, ping} ->
      io:format("Pong! ~n"),
      From ! {self(), pong},
      pingpong()
  end.
