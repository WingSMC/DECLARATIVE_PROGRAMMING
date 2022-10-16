defmodule Nhf1 do
  @moduledoc """
  Sátrak
  @author "Dremák Gergely <gergely089@gmail.com>"
  @date   "2022-10-13"
  """

  @type row         :: integer
  @type col         :: integer
  @type count       :: integer
  @type dir         :: :n | :e | :s | :w
  @type field       :: {row, col}
  @type tree        :: field
  @type tent        :: field
  @type row_counts  :: [count]
  @type col_counts  :: [count]
  @type size        :: {h::integer, w::integer}
  @type trees       :: [tree]
  @type tents       :: [tent]
  @type problem     :: {row_counts, col_counts, trees}
  @type dirs        :: [dir]

  @spec satrak(problem) :: dirs
  def satrak({_row_counts, _col_counts, _trees}) do
    #h = length row_counts
    #w = length col_counts

    #level = generate_excluded_map trees, {h, w}

    [:n]
  end

  #@spec generate_excluded_map(trees, size) :: map
  #defp generate_excluded_map(trees, {h, w}) do
  #  for row <- 1..h, col <- 1..w do
  #    {row, col} |> Map.put_new({row, col}, false)
  #  end
  #end

  @spec generate_directions(trees, tents) :: [dirs]
  def generate_directions(trees, tents) do
    generate_directions_h(trees, MapSet.new(tents))
    |> Enum.reject(& &1 === [])
    |> Enum.sort()
  end

  @spec generate_directions_h(trees, tents::MapSet.t(tent)) :: [dirs]
  defp generate_directions_h([], _), do: [[]]
  defp generate_directions_h([tree | trees_t], tents) do
    for tent <- tents do
      case generate_direction(tree, tent) do
        nil -> nil
        dir ->
          generate_directions_h(trees_t, MapSet.delete(tents, tent))
          |> Enum.map(& [dir | &1])
      end
    end
    |> Enum.reject(& &1 === nil)
    |> Enum.flat_map(& &1)
  end

  @spec generate_direction(tree, tent) :: dir | nil
  defp generate_direction({ty, tx}, {ny, nx}) do
    case {ty, tx} do
      {ty, ^nx} when ty - 1 === ny -> :n
      {^ny, tx} when tx + 1 === nx -> :e
      {ty, ^nx} when ty + 1 === ny -> :s
      {^ny, tx} when tx - 1 === nx -> :w
      _ -> nil
    end
  end
end

# !! negative rows / cols
# ?? anchor to trees ??

# 1. EXCLUSION
# exclude 0 cols & rows
# exclude cells not neighbouring trees

# 2. FINDING TENT PLACEMENT(S)
# find cols || rows with exactly missing number of empty cells
# find only cells near trees
# place tent at first available cell

# 3. EXCLUDE AFTER TENT(s) FOUND
# exclude cell neighbours
# exclude 0 cols & rows
# exclude tree neighbours not neighbouring other trees

# repeat last 2 steps no more trees


# sols
#   iex> Nhf1.satrak {[1, 1, 0, 3, 0], [1, 0, 2, 0, 2], [{1, 2}, {3, 3}, {3, 5}, {5, 1}, {5, 5}]}
#   [[:e, :s, :n, :n, :n]]
