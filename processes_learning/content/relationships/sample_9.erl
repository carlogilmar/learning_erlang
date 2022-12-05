%%% 9. Create a master process with children and implement restarting
%%% ==========================
-module(sample_9).
-export([receive_messages/1]).

receive_messages(ProcessName) ->
  io:format("\n I'm the process: ~p !! I'm alive!! ~p \n", [ProcessName, self()]),

  receive
    {new, NewProcessName} ->
      process_flag(trap_exit, true), % System Process
      spawn_link(sample_9, receive_messages, [NewProcessName]),
      receive_messages(NewProcessName);
    crash ->
      exit({"BOOM", ProcessName});
    {'EXIT', Pid, {"BOOM", ProcessToRestart}} ->
      io:fwrite("TRAPPING EXIT! A Linked Process crashed, isolated BOOM! \n"),
      io:fwrite("Process [~p] dead, restarting... \n", [Pid]),
      spawn_link(sample_9, receive_messages, [ProcessToRestart]),
      receive_messages(ProcessName);
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [ProcessName]),
      receive_messages(ProcessName)
  end.

