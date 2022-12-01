%%% 3. Creating linked process
%%% ==========================
-module(sample_3).
-export([receive_messages/1, create_linked_processes/0]).

create_linked_processes() ->
  Pid = spawn(sample_3, receive_messages, [0]),
  Pid ! create_linked_process.

receive_messages(ProcessNumber) when ProcessNumber < 5 ->
  receive
    create_linked_process ->
      io:format("\n Process alive is creating another process: ~p~n \n", [self()]),
      NextProcessNumber = ProcessNumber + 1,
      Pid = spawn(sample_3, receive_messages, [NextProcessNumber]),
      link(Pid),
      Pid ! create_linked_process,
      receive_messages(ProcessNumber);
    crash ->
      exit("Process Crashing! BOOM!");
    _msg ->
      io:fwrite("Process [~p] answer:: Hi!\n", [self()]),
      receive_messages(ProcessNumber)
  end;

receive_messages(ProcessNumber) when ProcessNumber >= 5 ->
    io:fwrite("Ring complete!").

%% How to run this code?
%% 1> c(sample_3).
%% {ok,sample_3}
%% 2> sample_3:create_linked_processes().
%% true
%% 4> pid(0,89,0) ! "Are u there?".
%% Process [<0.89.0>] answer:: Hi!
%% "Are u there?"
%% 5> pid(0,89,0) ! "Are u there?".
%% Process [<0.89.0>] answer:: Hi!
%% "Are u there?"
%% 6> is_process_alive(pid(0,89,0)).
%% true
%% 7> pid(0,89,0) ! crash.
%% crash
%% 8> is_process_alive(pid(0,89,0)).
%% false
