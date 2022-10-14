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
  def satrak({row_counts, col_counts, trees}) do
    h = length row_counts
    w = length col_counts

    level = generate_excluded_map trees {h, w}

    []
  end

  @spec generate_excluded_map(trees, size) :: map
  defp generate_excluded_map(trees, {h, w}) do
    for row <- 1..h, col <- 1..w do
      {row, col} |> Map.put_new({row, col}, false)
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
