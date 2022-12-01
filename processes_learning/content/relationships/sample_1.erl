%%% 1. Crashing a process
%%% ==========================
-module(sample_1).
-export([receive_messages/0]).

receive_messages() ->
  receive
    crash_process ->
      io:fwrite("Process is crashing..."),
      exit(reason);
    _msg ->
      io:fwrite("Hi, I'm the process!")
  end,
  receive_messages().

%%% How to run this code?
%%% c(sample_1).
%%% Pid = spawn(sample_1, receive_messages, []).
%%% is_process_alive(Pid).
%%% Pid ! say_hello.
%%% is_process_alive(Pid).
%%% Pid ! crash_process.
%%% is_process_alive(Pid). %% FALSE
