-module(my_bot_2).
-export([start/0, init/1]).

start() ->
  Pid = spawn(my_bot_2, init, [0]),
  Pid ! create_new_bot.

init(Bot_number) when Bot_number < 100000 ->
  io:format(">> Bot ~p is starting \n", [Bot_number]),
  receive
    say_hello ->
      io:format(">> Bot ~p :: Hello! ✌️\n", [Bot_number]);

    say_bye ->
      io:format(">> Bot ~p :: Bye! ✌️\n", [Bot_number]);

    create_new_bot ->
      io:fwrite("Bot is starting another bot"),
      Pid = spawn(my_bot_2, init, [Bot_number+ 1]),
      Pid ! create_new_bot
  end,
  init(Bot_number);

init(Bot_number) when Bot_number >= 100000 ->
  io:fwrite("Bots created DONE.").

%%% How to run this code?
%%% c(my_bot_2).
%%% my_bot_2:start().
