defmodule Statistics do
  def sequences([]), do: []

  @doc """
  Returns list of consecutive same elements sequences

  ## Examples

      iex> Statistics.sequences([1, 1, 2, 3, 3, 3, 4])
      [[1, 1], [2], [3, 3, 3], [4]]

  """
  def sequences(list) when is_list(list) do
    list
    |> Enum.chunk_by(&Function.identity/1)
  end

  def count(list, x) do
    list
    |> Enum.count(&(&1 == x))
  end

  @doc """
  Returns maps with sublists lengths

  ## Examples

      iex> Statistics.count_sublists_length([[1, 2, 3], [2, 3], [1], [3, 4], [13, 11]])
      %{1 => 1, 2 => 3, 3 => 1}

  """
  def count_sublists_length(lists) do
    lists
    |> Enum.frequencies_by(&length/1)
  end
end
