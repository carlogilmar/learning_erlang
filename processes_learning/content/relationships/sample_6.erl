%%% 6. Link two process and trapping exits signals
%%% ==========================
-module(sample_6).
-export([receive_messages/0, create_linked_process/0]).

create_linked_process() ->
  Pid = spawn(sample_6, receive_messages, []),
  Pid ! create_linked_process.

receive_messages() ->
  io:fwrite("Process [~p] ON! \n", [self()]),
  receive
    create_linked_process ->
      process_flag(trap_exit, true),
      spawn_link(sample_6, receive_messages, []);

    crash_process ->
      io:fwrite("Process is crashing..."),
      exit(reason);

    {'EXIT', _pid, _msg} ->
      io:fwrite("TRAPPING EXIT! A Linked Process crashed BOOM! \n");

    _msg ->
      io:fwrite("Hi, I'm the process!")
  end,
  receive_messages().

%% Eshell V13.0.3
%% 1> c(sample_6).
%% {ok,sample_6}
%% 2> sample_6:create_linked_process().
%% Process [<0.87.0>] ON!
%% create_linked_process
%% Process [<0.87.0>] ON!
%% Process [<0.88.0>] ON!
%% 3> pid(0,88,0) ! crash_process.
%% Process is crashing...crash_process
%% A Linked Process crashed BOOM!
%% Process [<0.87.0>] ON!
