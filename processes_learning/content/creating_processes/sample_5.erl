%%% 5. Processes creating processes
%%% ==========================
-module(sample_5).
-export([start_creation/0, init/1]).

start_creation() ->
  Pid = spawn(sample_5, init, [0]),
  Pid ! start.

init(Counter) when Counter < 1000 ->
  io:format("\nBot is alive!: ~p~n \n", [self()]),
  receive
    start ->
      io:format(">> Bot Counter: ~p~n \n", [Counter]),
      Pid = spawn(sample_5, init, [Counter + 1]),
      Pid ! start,
      init(Counter);
    _msg ->
		  io:fwrite("I'm the bot!")
  end;

init(Counter) when Counter >= 1000 ->
  io:fwrite("Es TODO!").

%%% How to run this code?
%%% 1. Start the Erlang Shell with the flag to allow the max number of processes
%%%  erl +P 134217727
%%% 2. Run the code
%%% 1> c(bot).
%%% 2> bot:start().
