-module(brother).
-export([waiting_for_msg/0, waiting_for_msg_and_terminate/0, create_link_brother/0]).

waiting_for_msg() ->
  io:format("\nBrother is alive! ~p~n \n", [self()]),
  receive
     _msg ->
       io:format("\n Process ~p~n here \n", [self()]),
       waiting_for_msg()
  end.

waiting_for_msg_and_terminate() ->
  io:format("\nBrother is alive! ~p~n \n", [self()]),
  receive
     _msg ->
       exit("Process dies here!") % You need to kill the process
  end.

%% erlang:process_info(pid(0,0,0)).
create_link_brother() ->
  link(spawn(brother, waiting_for_msg_and_terminate, [])),
  waiting_for_msg().

