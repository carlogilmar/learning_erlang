-module(siblings).
-export([waiting_for_msg/0, waiting_for_msg_and_terminate/0, create_processes_linked/0]).

waiting_for_msg() ->
  receive
    {'EXIT', _pid, _reason} ->
      io:format("~nLinked process died, creating new process... ", []),
      process_flag(trap_exit, true),
      spawn_link(siblings, waiting_for_msg_and_terminate, []);
    Msg ->
       io:format("Process:  ~p", [Msg])
  end,
  waiting_for_msg().

waiting_for_msg_and_terminate() ->
  io:format("~nSibling process: ~p", [self()]),
  receive
     _msg -> io:format("Brother is alive! ~p", [self()])
   after 2000 ->
      io:format("~n Killing process ~p", [self()]),
      exit("Process dies here!")
  end.

%% Create infinite linked processes
%% spawn(siblings, create_processes_linked, [])
create_processes_linked() ->
  io:format("Parent process: ~p", [self()]),
  process_flag(trap_exit, true),
  spawn_link(siblings, waiting_for_msg_and_terminate, []),
  waiting_for_msg().

