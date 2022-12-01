%%% 4. Create many live processes
%%% ==========================
-module(sample_4).
-export([create_process/1, start_process/1, create_5_processes/0]).

create_5_processes() ->
  ProcessesToCreate = [1,2,3,4,5],
  [sample_4:create_process(ProcessName) || ProcessName <- ProcessesToCreate].

create_process(ProcessName) ->
  spawn(sample_3, start_process, [ProcessName]).

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
