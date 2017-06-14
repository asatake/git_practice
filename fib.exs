defmodule Memorize do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib x do
    case Agent.get(__MODULE__, &Map.get(&1, x)) do
      nil ->
        f = fib(x - 1) + fib(x - 2)
        Agent.update(__MODULE__, &Map.put(&1, x, f))
        f
      f -> f
    end
  end

  def start_agent do
    Agent.start_link &Map.new/0, name: __MODULE__
  end
end

Memorize.start_agent
Memorize.fib(20000)
|> IO.inspect
