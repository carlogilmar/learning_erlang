-module(frequency).
-export([start/0, add/1, loop/1]).

start() ->
  io:fwrite(" Soy Server de Erlang perro 🚀 \n"),
  register(server, spawn(frequency, loop, [[]])),
  io:fwrite(" Listones!!!! \n").

add(Freq) ->
  server ! {add, Freq}.

loop(Freqs) ->
  io:fwrite(" Server de Erlang ON ✅  \n"),
  receive
    {add, Freq} ->
      FreqsUpd = Freqs ++ [Freq],
      io:format("DONE Added  ~p~n  \n", [Freq]),
      loop(FreqsUpd);
    _other ->
      loop(Freqs)
  end.
