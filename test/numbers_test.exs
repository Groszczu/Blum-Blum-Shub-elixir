defmodule NumbersTest do
  use ExUnit.Case, async: true
  import Numbers

  describe "prime?/1" do
    test "returns true for prime numbers" do
      assert true ==
               [2, 3, 5, 7, 11, 13, 19, 29, 59, 79]
               |> Enum.all?(&prime?/1)
    end

    test "returns false for not prime numbers" do
      assert false ==
               [1, 4, 8, 12, 15, 24, 33, 45, 64, 80]
               |> Enum.any?(&prime?/1)
    end
  end
end
