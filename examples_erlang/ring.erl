-module(ring).
-export([start/0, loop/0, handle/1, send_to_new_process/1]).

start() ->
  io:fwrite(" Soy el Ring prro \n"),
  io:fwrite(" 1. Creando proceso inicial \n"),
  Pid = spawn(ring, loop, []),
  io:format("~p~n", [Pid]),
  io:fwrite(" 2. Enviando mensajito \n"),
  Pid ! {1}.

loop() ->
  io:fwrite(" LOOP --- \n"),
  receive
    {Counter} ->
      io:fwrite(" LOOP here! \n"),
      handle(Counter);
    {Counter, _Msg} ->
      io:fwrite(" Nothing! \n")
  end.

handle(Counter) when Counter < 5 ->
  io:fwrite(" Soy el nuevo proceso del Ring prro \n"),
  io:format("~p~n", [self()]),
  send_to_new_process(Counter);

handle(Counter) when Counter == 5 ->
  io:fwrite(" Terminamos!!!! \n").

send_to_new_process(Counter) ->
  New_counter = Counter+1,
  io:fwrite(" Creando nuevo proceso \n"),
  Pid = spawn(ring, loop, []),
  io:fwrite(" Enviando... \n"),
  io:format("Desde ~p~n", [self()]),
  io:format("Al nuevo: ~p~n", [Pid]),
  Pid ! {New_counter}.
