-module(my_process_2).
-export([receive_messages/1]).

receive_messages(Messages_received) ->
  receive
    say_hello = Msg ->
      io:fwrite("Hello, I'm the process!"),
      receive_messages([Msg|Messages_received]);

    say_bye = Msg ->
      io:fwrite("Bye, I'm the process!"),
      receive_messages([Msg|Messages_received]);

    print_all_messages_received ->
      io:format("Messages received: ~p~n \n", [Messages_received]),
      receive_messages(Messages_received)
  end.

%%% How to run this code?
%%% c(my_process_2).
%%% Pid = spawn(my_process_2, receive_messages, [[]]).
%%% is_process_alive(Pid).
%%% Pid ! say_hello.
%%% is_process_alive(Pid).
%%% Pid ! say_bye.
