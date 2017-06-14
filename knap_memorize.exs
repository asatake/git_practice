defmodule Sack do
  def knapsack([w, wt, val, n]) do
    cond do
      w == 0 || n == 0 -> 0
      Enum.at(wt, n - 1) > w ->
        case Agent.get(__MODULE__, &Map.get(&1, [w, wt, val, n])) do
          nil ->
            k = knapsack([w, wt, val, n - 1])
            Agent.update(__MODULE__, &Map.get(&1, [w, wt, val, n], k))
            k
          k -> k
        end
      true ->
        case Agent.get(__MODULE__, &Map.get(&1, [w, wt, val, n])) do
          nil ->
            kf = knapsack([w - Enum.at(wt, n - 1), wt, val, n])
            Agent.update(__MODULE__, &Map.get(&1, [w - Enum.at(wt, n - 1), wt, val, n - 1], kf))
            kf
          kf -> kf
        end
        case Agent.get(__MODULE__, &Map.get(&1, [w, wt, val, n])) do
          nil ->
            kl = knapsack([w, wt, val, n - 1])
            Agent.update(__MODULE__, &Map.get(&1, [w, wt, val, n - 1], kl))
            kl
          kl -> kl
        end
        Enum.max([kf, kl])
    end
  end
  def start_agent do
    Agent.start_link &Map.new/0, name: __MODULE__
  end
end

l = Enum.to_list(1..5)
val = for x <- l, do: round(x * 55 / 2)
wt = for x <- l, do: x * 20
w = Enum.count(val) * 100
n = Enum.count(val)
Sack.start_agent
Sack.knapsack([w, wt, val, n])
|> IO.inspect
