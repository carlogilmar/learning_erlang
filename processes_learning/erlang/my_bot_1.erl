-module(my_bot_1).
-export([init/1]).

init(Bot_number) ->
  receive
    say_hello ->
      io:format(">> Bot ~p :: Hello! ✌️\n", [Bot_number]);

    say_bye ->
      io:format(">> Bot ~p :: Bye! ✌️\n", [Bot_number])
  end,
  init(Bot_number).

%%% How to run this code?
%%% Pid = spawn(my_bot_1, init, [1]).
%%% Pid ! say_hello.
%%% is_process_alive(Pid).
%%% Pid ! say_bye.
