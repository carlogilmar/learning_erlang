%%% 1. Creating a process
%%% ==========================
-module(sample_1).
-export([receive_messages/0]).

receive_messages() ->
  receive
    say_hello ->
      io:fwrite("Hello, I'm the process!");

    say_bye ->
      io:fwrite("Bye, I'm the process!")
  end,
  receive_messages().

%%% How to run this code?
%%% c(sample_1).
%%% Pid = spawn(sample_1, receive_messages, []).
%%% is_process_alive(Pid).
%%% Pid ! say_hello.
%%% is_process_alive(Pid).
%%% Pid ! say_bye.
