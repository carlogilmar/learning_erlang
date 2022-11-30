-module(monitors).
-export([create_process/0, waiting_for_monitor/1, start_monitor/0]).

create_process() ->
  receive
     _msg -> io:format("Brother is alive! ~p", [self()])
   after 2000 ->
      io:format("~n Killing this process ", []),
      exit("Terminating...")
  end.

waiting_for_monitor(Reference) ->
  receive
    {'DOWN', Reference, process, _Pid, _Reason} ->
      io:format("~n The process monitored is down ", []);
    _msg ->
      io:format("~n Parent process here!", [])
  end,
  waiting_for_monitor(Reference).

start_monitor() ->
  io:format("~nParent process, creating process and starting monitor", []),
  No_linked_process = spawn(monitor, create_process, []),
  Reference = erlang:monitor(process, No_linked_process),
  waiting_for_monitor(Reference).
