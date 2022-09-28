defmodule MyBot do
  @moduledoc """
    iex> pid = spawn(MyBot, :init, [1]); send(pid, :create_new_bot)
  """
  def init(bot_number) when bot_number < 100_000 do
    IO.puts "BOT #{bot_number} is starting..."
    receive do
      :say_hello->
        IO.puts "🤖 Bot <#{bot_number}> :: Hello! ✌️..."
      :say_bye ->
        IO.puts "🤖 Bot <#{bot_number}> :: Bye! 👋"
      :create_new_bot ->
        IO.puts "🤖 Bot is starting another bot..."
        new_bot_pid = spawn(MyBot, :init, [bot_number+1])
        send(new_bot_pid, :create_new_bot)
    end

    init(bot_number)
  end

  def init(_bot_number) do
    IO.puts "Bots created DONE."
  end

  def create_processes do
    pid = spawn(MyBot, :init, [1])
    send(pid, :create_new_bot)
  end

end
