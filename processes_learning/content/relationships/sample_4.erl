%%% 4. Creating 1000 linked processes
%%% ==========================
-module(sample_4).
-export([receive_messages/1, create_linked_processes/0]).

create_linked_processes() ->
  Pid = spawn(sample_4, receive_messages, [0]),
  Pid ! create_linked_process.

receive_messages(ProcessNumber) when ProcessNumber < 1000 ->
  receive
    create_linked_process ->
      io:format("\n Process alive is creating another process: ~p~n \n", [self()]),
      NextProcessNumber = ProcessNumber + 1,
      Pid = spawn(sample_4, receive_messages, [NextProcessNumber]),
      link(Pid),
      Pid ! create_linked_process,
      receive_messages(ProcessNumber);
    crash ->
      exit("Process Crashing! BOOM!");
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages(ProcessNumber)
  end;

receive_messages(ProcessNumber) when ProcessNumber >= 1000 ->
    io:fwrite("Ring complete! 1000 process are alive!").

