defmodule BSSTest do
  @moduledoc """
  Module with FIPS 140-2 statistic tests
  """

  use ExUnit.Case, async: true

  @number_of_bits 20000
  @single_bits_low 9725
  @single_bits_high 10275

  setup_all do
    random_bits = BSS.generate_random_bits(@number_of_bits)

    sequences_lengths =
      random_bits |> Statistics.sequences() |> Statistics.count_sublists_length()

    %{random_bits: random_bits, sequences_lengths: sequences_lengths}
  end

  describe "generate_random_bits/1" do
    test "should generate from #{@single_bits_low} to #{@single_bits_high} single bits", %{
      random_bits: random_bits
    } do
      single_bits = Statistics.count(random_bits, "1")

      IO.puts("Single bits: #{single_bits}")

      assert single_bits > @single_bits_low
      assert single_bits < @single_bits_high
    end

    test "should generate sequences within allowed boundaries", %{
      sequences_lengths: sequences_lengths
    } do
      twos = Map.get(sequences_lengths, 2)
      threes = Map.get(sequences_lengths, 3)
      fours = Map.get(sequences_lengths, 4)
      fives = Map.get(sequences_lengths, 5)
      sixes = Map.get(sequences_lengths, 6)

      sevens_or_grater =
        sequences_lengths
        |> Enum.reduce(0, fn
          {length, quantity}, acc when length >= 7 -> acc + quantity
          _, acc -> acc
        end)

      IO.inspect(sequences_lengths)

      assert twos > 2315
      assert twos < 2685
      assert threes > 1114
      assert threes < 1386
      assert fours > 527
      assert fours < 723
      assert fives > 240
      assert fives < 384
      assert sixes > 103
      assert sixes < 209
      assert sevens_or_grater > 103
      assert sevens_or_grater < 209
    end

    test "should not generate sequence longer than 25", %{sequences_lengths: sequences_lengths} do
      greater_than_25 =
        sequences_lengths
        |> Enum.reduce(0, fn
          {length, quantity}, acc when length >= 26 -> acc + quantity
          _, acc -> acc
        end)

      assert greater_than_25 == 0
    end

    test "should pass poker test", %{random_bits: bits} do
      sum_of_squares =
        bits
        |> Enum.chunk_every(4)
        |> Enum.map(&(Enum.join(&1) |> Integer.parse(2) |> Tuple.to_list() |> hd))
        |> Enum.frequencies()
        |> Map.values()
        |> Enum.reduce(0, fn x, acc -> x * x + acc end)

      x = sum_of_squares * 16 / 5000 - 5000

      IO.puts("Poker test: X = #{x}")

      assert x > 2.16
      assert x < 46.17
    end
  end
end
