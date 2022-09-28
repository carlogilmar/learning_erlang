% 2. Export module
-module(writter).
% 2. Export public functions
-export([start/0, wait_to_process_msg/0]).

%%% How to call this code inside a process?
% 1> c(writter).
% 2> spawn(fun() -> writter:start() end).
start() ->
  io:fwrite(" Soy Server de Erlang 🚀 ").

% - No receive any argument
% - You can call this inside a process to wait to process message
% - After execute this code the process will terminate

% HOW TO RUN THIS CODE? =====================================
% c(writter).
% Pid = spawn(fun() -> writter:wait_to_process_msg() end).
% Pid ! "Hi". % Message passing
% ===========================================================
wait_to_process_msg() ->
  io:fwrite("\nWritter ready to answer>>>\n"),
  receive
    hi ->
		  io:fwrite("Writter> Hiiiiiiii!\n");
    bye ->
		  io:fwrite("Writter> Byeeeeee!\n");
    _ ->
		  io:fwrite("Writter> Try Again!\n")
  end,
  wait_to_process_msg().
