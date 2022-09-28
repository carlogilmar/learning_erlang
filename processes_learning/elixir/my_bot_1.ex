defmodule MyBot do
  @moduledoc"""
    iex> pid = spawn(MyBot, :init, [1])
    iex> send(pid, :start)
    iex> Process.alive?(pid)
  """
  def init(bot_number) do
    receive do
      :say_hello->
        IO.puts "🤖 Bot <#{bot_number}> :: Hello! ✌️..."
      :say_bye ->
        IO.puts "🤖 Bot <#{bot_number}> :: Bye! 👋"
    end

    init(bot_number)
  end
end
