defmodule Khf3 do

  @moduledoc """
  Kemping helyessége
  @author "Dremák Gergely <gergely089@gmai.com>"
  @date   "2022-10-7"
  """

  @type row   :: integer                                            # sor száma (1-től n-ig)
  @type col   :: integer                                            # oszlop száma (1-től m-ig)
  @type field :: {row, col}                                         # egy parcella koordinátái
  @type tents_count_rows :: [integer]                               # a sátrak száma soronként
  @type tents_count_cols :: [integer]                               # a sátrak száma oszloponként
  @type trees       :: [field]                                      # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type tents       :: [field]                                      # a sátrakat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type puzzle_desc :: {tents_count_rows, tents_count_cols, trees}  # a feladványleíró hármas
  @type dir       :: :n | :e | :s | :w                              # a sátorpozíciók iránya: north, east, south, west
  @type tent_dirs :: [dir]                                          # a sátorpozíciók irányának listája a fákhoz képest
  @type cnt_tree  :: integer                                        # a fák száma a kempingben
  @type cnt_tent  :: integer                                        # az elemek száma a sátorpozíciók irányának listájában
  @type err_rows  :: %{err_rows:  [integer]}                        # a sátrak száma rossz a felsorolt sorokban
  @type err_cols  :: %{err_cols:  [integer]}                        # a sátrak száma rossz a felsorolt oszlopokban
  @type err_touch :: %{err_touch: [field]}                          # a felsorolt koordinátájú sátrak másikat érintenek
  @type errs_desc :: {err_rows, err_cols, err_touch}                # hibaleíró hármas

  @spec check_sol(pd::puzzle_desc, ds::tent_dirs) :: ed::errs_desc
  def check_sol({rows, cols, tree_coords}, tent_dirs) do
    tent_coords =
      tree_coords
      |> Enum.zip(tent_dirs)
      |> Enum.map(fn {{y, x}, tent} ->
        {dy, dx} =
          case tent do
            :n -> {-1, 0}
            :e -> {0, 1}
            :s -> {1, 0}
            :w -> {0, -1}
          end
        {dy + y, dx + x}
      end)
      |> Enum.sort()

    err_rows = check_rows(rows, tent_coords)
    err_cols = check_cols(cols, tent_coords)
    err_touch = check_touch(tent_coords)

    {err_rows, err_cols, err_touch}
  end

  @spec check_rows(tents_count_rows, tents) :: err_rows
  defp check_rows(rows, coords) do
    %{err_rows: errs(rows, Enum.map(coords, fn {y, _x} -> y end))}
  end
  @spec check_cols(tents_count_rows, tents) :: err_cols
  defp check_cols(cols, coords) do
    %{err_cols: errs(cols, Enum.map(coords, fn {_y, x} -> x end))}
  end

  @spec errs(axis_counts::[integer], axis_actuals::[integer]) :: [integer]
  defp errs(as, aas) do
    solution_map =
      Enum.group_by(aas, & &1)
      |> Map.to_list()
      |> Enum.map(fn {k, v} -> {k, length(v)} end)
      |> Map.new()

    for i <- 1..length(as) do
      actual_count = case solution_map[i] do
        nil -> 0
        v -> v
      end
      this_should_be_the_count = Enum.at(as, i - 1)
      if  actual_count === this_should_be_the_count or this_should_be_the_count < 0 do
        nil else i
      end
    end
    |> Enum.reject(& &1 === nil)
  end

  @spec check_touch(tents) :: err_touch
  defp check_touch(coords) do
    touches =
      coords
      |> Enum.filter(fn {y, x} ->
        Enum.any?(coords, fn {y2, x2} ->
          dy = y2 - y
          dx = x2 - x
          dy in [-1, 0, 1] and dx in [-1, 0, 1] and not (dy === 0 and dx === 0)
        end)
      end)

    %{err_touch: touches}
  end
end
