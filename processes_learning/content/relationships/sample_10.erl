%%% 10. Monitor a process
%%% ==========================
-module(sample_10).
-export([receive_messages/0]).

receive_messages() ->
  io:format("\n I'm the process: ~p !! I'm alive!! \n", [self()]),

  receive
    crash ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      exit("BOOM, can you see me in your monitor?");
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages()
  end.

%%% How to run this code?
%%% Eshell V13.0.3  (abort with ^G)
%%% 1> c(sample_10).
%%% {ok,sample_10}
%%% 2> {Pid, Ref} = spawn_monitor(sample_10, receive_messages, []).
%%% I'm the process: <0.87.0> !! I'm alive!!
%%% {<0.87.0>,#Ref<0.2373354022.816054273.130267>}
%%%
%%% 3> Pid ! crash.
%%% crash
%%%
%%% 5> flush().
%%% Shell got {'DOWN',#Ref<0.2373354022.816054273.130267>,process,<0.87.0>,
%%% "BOOM, can you see me in your monitor?"}
%%% ok
%%%
%%% 7> register(my_process, Pid2).
%%% true
%%% 8> whereis(my_process).
%%% <0.92.0>
