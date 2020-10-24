defmodule Numbers do
  def prime?(1), do: false
  def prime?(2), do: true
  def prime?(3), do: true
  def prime?(5), do: true
  def prime?(7), do: true
  def prime?(n) when rem(n, 2) == 0, do: false

  def prime?(n) do
    limit = [7, round(:math.sqrt(n))] |> Enum.max()

    Stream.iterate(3, &(&1 + 2))
    |> Stream.take_while(&(&1 <= limit))
    |> Stream.filter(&(rem(n, &1) == 0))
    |> Enum.empty?()
  end

  def coprime?(a, b), do: Integer.gcd(a, b) == 1
end
