%%% 2. Link two processes and crash one
%%% ==========================
-module(sample_2).
-export([receive_messages/0, create_linked_process/0]).

create_linked_process() ->
  Pid = spawn(sample_2, receive_messages, []),
  Pid ! create_linked_process.

receive_messages() ->
  io:fwrite("Process [~p] ON! \n", [self()]),
  receive
    create_linked_process ->
      % link(Pid)
      link(spawn(sample_2, receive_messages, []));

    crash_process ->
      io:fwrite("Process is crashing..."),
      exit(reason);
    _msg ->
      io:fwrite("Hi, I'm the process!")
  end,
  receive_messages().

%%% How to run this code?
%%% c(sample_2).
%%% sample_2:create_linked_process().
%%% is_process_alive(pid(0,87,0)).
%%% is_process_alive(pid(0,86,0)).
%%% pid(0, 87, 0) ! crash_process.
%%% Both process should be terminated after this.
%%% is_process_alive(pid(0,87,0)).
%%% is_process_alive(pid(0,86,0)).
