defmodule BSS do
  import Numbers

  @doc """
  Returns product of two prime numbers `p`, `m`, grater than `greater_than` such as: `p mod 4 == 3` and `m mod 4 == 3`
  """
  def get_n(greater_than) do
    # Stream of numbers x that x mod 4 == 3
    Stream.iterate(
      greater_than + 3 - rem(greater_than, 4),
      &(&1 + 4)
    )
    |> Stream.filter(&prime?/1)
    |> Stream.take(100)
    |> Enum.take_random(2)
    |> IO.inspect()
    |> Enum.reduce(&*/2)
  end

  @doc """
  Generates random `count` bits
  """
  def generate_random_bits(count \\ 20_000) do
    n = get_n(1_000_000)

    x =
      Stream.iterate(round(n / 2), &(&1 + 1))
      |> Stream.filter(&coprime?(&1, n))
      |> Stream.take(100)
      |> Enum.random()

    x0 = rem(x * x, n)

    IO.puts("N = #{n}")
    IO.puts("x = #{x}")
    IO.puts("x0 = #{x0}")

    Stream.iterate(x0, &rem(&1 * &1, n))
    |> Stream.take(count)
    |> Stream.map(&(Integer.to_string(&1, 2) |> String.last()))
    |> Enum.to_list()
  end
end
