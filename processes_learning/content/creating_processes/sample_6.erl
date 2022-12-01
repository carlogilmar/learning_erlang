%%% 6. Creating ring process
%%% ==========================
-module(sample_6).
-export([start_ring_creation/0, create_process/1, receive_messages/1]).

start_ring_creation() ->
  create_process(0).

create_process(ProcessNumber) ->
  Pid = spawn(sample_6, receive_messages, [ProcessNumber]),
  Pid ! create_another_process.

receive_messages(ProcessNumber) when ProcessNumber < 5 ->
  receive
    create_another_process ->
      io:format("\n Process alive is creating another process: ~p~n \n", [self()]),
      NextProcessNumber = ProcessNumber + 1,
      create_process(NextProcessNumber),
      receive_messages(ProcessNumber);
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages(ProcessNumber)
  end;

receive_messages(ProcessNumber) when ProcessNumber >= 5 ->
    io:fwrite("Ring complete!").

