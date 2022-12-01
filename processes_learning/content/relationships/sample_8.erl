%%% 8. Create a master process with children and trap exit signals
%%% ==========================
-module(sample_8).
-export([receive_messages/0]).

receive_messages() ->
  io:format("\n Process is alive: ~p~n \n", [self()]),

  receive
    create_linked_process ->
      process_flag(trap_exit, true), % System Process
      spawn_link(sample_8, receive_messages, []),
      receive_messages();
    crash ->
      exit("Process Crashing! BOOM!");
    {'EXIT', Pid, _msg} ->
      io:fwrite("TRAPPING EXIT! A Linked Process crashed, isolated BOOM! \n"),
      io:fwrite("Process [~p] dead\n", [Pid]),
      receive_messages();
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages()
  end.

%% How to run this code
%% Eshell V13.0.3  (abort with ^G)
%% 1> c(sample_8).
%% {ok,sample_8}
%% 2> Pid = spawn(sample_8, receive_messages, []).
%%  Process is alive: <0.87.0>
%% 3> Pid ! create_linked_process.
%% 4> Pid ! create_linked_process.
%% 5> Pid ! create_linked_process.
%% 6> Pid ! create_linked_process.
%% 7> pid(0, 95, 0) ! crash.
%% TRAPPING EXIT! A Linked Process crashed, isolated BOOM!
%% crash
%% Process [<0.95.0>] dead
%% Process is alive: <0.87.0>
%% 8> is_process_alive(pid(0, 95, 0)).
%% false
%% 9> is_process_alive(pid(0, 93, 0)).
%% true
%% 10> is_process_alive(pid(0, 91, 0)).
%% true
