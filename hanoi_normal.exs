defmodule Hanoi do
  def hanoi(1, a, b, c) do
    [a, b, c]
  end
  def hanoi(n, a, b, c) do
    hanoi(n - 1, a, c, b)
    hanoi(n - 1, c, b, a)
  end
end

Hanoi.hanoi(27, 'a', 'b', 'c')
