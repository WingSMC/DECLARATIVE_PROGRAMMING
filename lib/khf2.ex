defmodule Khf2 do
  @moduledoc """
  Kemping térképe
  @author "Dremák Gergely <gergely089@gmail.com>"
  @date   "2022-10-02"
  """

  @type row         :: integer                                      # sor száma (1-től n-ig)
  @type col         :: integer                                      # oszlop száma (1-től m-ig)
  @type field       :: {row, col}                                   # egy parcella koordinátái
  @type obstacle    :: {String.t, {integer, integer}}               # valami akadály jelölése és a helye
  @type tents_count_rows :: [integer]                               # a sátrak száma soronként
  @type tents_count_cols :: [integer]                               # a sátrak száma oszloponként
  @type trees       :: [field]                                      # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type obstacles   :: [obstacle]                                   # a fák és a sátrak jelölései és koordinátái lexikálisan rendezve
  @type puzzle_desc :: {tents_count_rows, tents_count_cols, trees}  # a feladványleíró hármas
  @type dir         :: :n | :e | :s | :w                            # a sátorpozíciók iránya: north, east, south, west
  @type tent_dirs   :: [dir]

  @spec to_external(pd :: puzzle_desc, ds :: tent_dirs, file :: String.t()) :: :ok
  def to_external(pd, ds, file) do
    File.write!(file, to_string(pd, ds))
  end                              # a sátorpozíciók irányának listája a fákhoz képest

  @spec to_string(puzzle_desc, tent_dirs) :: String.t
  def to_string({rows, cols, tree_coords}, tent_dirs) do
    tent_coords =
      tree_coords
      |> Enum.zip(tent_dirs)
      |> Enum.map(fn {{y, x}, tent} ->
        {ds, {dy, dx}} =
          case tent do
            :n -> {"N", {-1, 0}}
            :e -> {"E", {0, 1}}
            :s -> {"S", {1, 0}}
            :w -> {"W", {0, -1}}
          end
        {ds, {dy + y, dx + x}}
      end)

    obstacles = Enum.map(tree_coords, &({"*", &1})) ++ tent_coords

    cell_size = 4
    w = Enum.count(cols)
    h = Enum.count(rows)

    string_rows = for y <- 1..h do
      row = for x <- 1..w do
        case Enum.find(obstacles, fn {_, c} -> c === {y, x} end) do
          nil -> "-"
          {ds, _} -> ds
        end
        |> String.pad_leading(cell_size)
      end
      row_count_string = Integer.to_string(Enum.at(rows, y - 1))
      "#{String.pad_leading(row_count_string, cell_size)}#{Enum.join(row)}\n"
    end

    first_line = cols
    |> Enum.map(&(String.pad_leading(Integer.to_string(&1), cell_size)))
    |> Enum.join()

    "#{String.duplicate(" ", cell_size)}#{first_line}\n#{Enum.join(string_rows)}"
  end
end
