defmodule Sack do
  def knapsack(w, wt, val, n) do
    cond do
      w == 0 || n == 0 -> 0
      Enum.at(wt, n - 1) > w -> knapsack(w, wt, val, n - 1)
      true ->
        Enum.max(
          [Enum.at(val, n - 1) + knapsack(w - Enum.at(wt, n - 1), wt, val, n - 1),
           knapsack(w, wt, val, n - 1)
          ]
        )
    end
  end
end

l = Enum.to_list(1..25)
val = for x <- l, do: round(x * 55 / 2)
wt = for x <- l, do: x * 20
w = Enum.count(val) * 100
n = Enum.count(val)
Sack.knapsack(w, wt, val, n)
|> IO.inspect
