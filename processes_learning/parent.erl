-module(parent).
-export([create_childs/0, create_dead_child/1]).

supervisor_waiting() ->
  receive
    {'EXIT', _pid, Process_name} ->
      io:format("~nLinked process ~p died, creating new process... ", [Process_name]),
      spawn_link(parent, create_dead_child, [Process_name]);
    Msg ->
       io:format("Process:  ~p", [Msg])
  end,
  supervisor_waiting().


create_dead_child(Name) ->
  io:format("~nSibling process name: ~p", [Name]),
  receive
     _msg -> io:format("Brother is alive! ~p", [self()])
   after 2000 ->
      io:format("~n Killing process ~p", [Name]),
      exit(Name)
  end.

create_childs() ->
  io:format("~nParent process, creating 3 childs: ~p", [self()]),
  process_flag(trap_exit, true),
  spawn_link(parent, create_dead_child, ["A"]),
  spawn_link(parent, create_dead_child, ["B"]),
  spawn_link(parent, create_dead_child, ["C"]),
  supervisor_waiting().

