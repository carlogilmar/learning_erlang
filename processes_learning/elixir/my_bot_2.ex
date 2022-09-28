defmodule MyBot do
  def init(bot_number) do
    IO.puts "BOT #{bot_number} is starting..."
    receive do
      :say_hello->
        IO.puts "🤖 Bot <#{bot_number}> :: Hello! ✌️..."
      :say_bye ->
        IO.puts "🤖 Bot <#{bot_number}> :: Bye! 👋"
    end

    init(bot_number)
  end

  def create_bots(number_of_bots) do
    Enum.map(1..number_of_bots, fn index -> spawn(Bot, :init, [index]) end)
  end
end
