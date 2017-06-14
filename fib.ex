defmodule Memorize do
  def fib(0), do: 0
  def fib(1), do: 1

  def fib x do
    case Agent.get(:fib_memo, &Map.get(&1, x)) do
      nil ->
        v = fib(x - 1) + fib(x - 2)
        Agent.update(:fib_memo, &Map.put(&1, x, v))
        v
      v -> v
    end
  end

  def start_agent do
    Agent.start_link &Map.new/0, name: :fib_memo
  end
end

Memorize.start_agent
IO.inspect Memorize.fib 1024
