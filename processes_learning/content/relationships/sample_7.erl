%%% 7. Creating 1000 linked processes using spawn_link and trapping exits signals
%%% ==========================
-module(sample_7).
-export([receive_messages/1, create_linked_processes/0]).

create_linked_processes() ->
  Pid = spawn(sample_7, receive_messages, [0]),
  Pid ! create_linked_process.

receive_messages(ProcessNumber) when ProcessNumber < 1000 ->
  receive
    create_linked_process ->
      io:format("\n Process alive is creating another process: ~p~n \n", [self()]),
      NextProcessNumber = ProcessNumber + 1,
      process_flag(trap_exit, true), % System Process
      Pid = spawn_link(sample_7, receive_messages, [NextProcessNumber]),
      Pid ! create_linked_process,
      receive_messages(ProcessNumber);
    crash ->
      io:fwrite("Crashing process!"),
      exit("Process Crashing! BOOM!");
    {'EXIT', Pid, _msg} ->
      io:fwrite("TRAPPING EXIT! A Linked Process crashed, isolated BOOM! \n"),
      io:fwrite("Process [~p] dead\n", [Pid]),
      receive_messages(ProcessNumber);
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages(ProcessNumber)
  end;

receive_messages(ProcessNumber) when ProcessNumber >= 1000 ->
    io:fwrite("Ring complete! 1000 process are alive!").

