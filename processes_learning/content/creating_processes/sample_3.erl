%%% 3. Create a process, hold the state and keep alive
%%% ==========================
-module(sample_3).
-export([start_process/1]).

start_process(ProcessName) ->
  receive
    _msg ->
      io:fwrite("Hello I'm the process ~p~n \n", [ProcessName])
  end,
  start_process(ProcessName).

%%% How to run this code?
%%% c(sample_1).
%%% Pid1 = spawn(sample_1, start_process, ["Proceso1"])
%%% Pid1 ! "Hii"
%%% is_process_alive(Pid1)
