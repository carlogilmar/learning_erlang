defmodule MyProcess do
  @moduledoc"""
    c "my_process.ex"
    pid = spawn(MyProcess, :receive_messages, [])
    send(pid, :say_hello)
    Process.alive?(pid)
  """
  def receive_messages() do
    receive do
      :say_hello->
        IO.puts "Hello, I'm the process!"
      :say_bye ->
        IO.puts "Bye, I'm the process!"
    end
  end
end
