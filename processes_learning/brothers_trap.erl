-module(brothers_trap).
-export([waiting_for_msg/0, waiting_for_msg_and_terminate/0, create_link_brother/0]).

waiting_for_msg() ->
  receive
    {'EXIT', _pid, _msg} ->
      io:fwrite("== linked process died :( sorry"),
       waiting_for_msg();
     _msg ->
       io:format("\n Process ~p~n here \n", [self()]),
       waiting_for_msg()
  end.

waiting_for_msg_and_terminate() ->
  io:format("\nBrother is alive! ~p~n \n", [self()]),
  receive
     _msg ->
       io:format("Process terminating...", []),
       exit("Process dies here!") % You need to kill the process
  end.

%% erlang:process_info(pid(0,0,0)).
%% Create a process with this function to create the linked process
%% Parent = spawn(brother, create_link_brother, []).
%% is_process_alive(pid)
create_link_brother() ->
  process_flag(trap_exit, true), % Parent is going to trap exits
  spawn_link(brother, waiting_for_msg_and_terminate, []),
  waiting_for_msg().

