defmodule Khf1 do
  @moduledoc """
  Kemping
  @author "Dremák Gergely <gergely089@gmail.com>"
  @date   "2022-9-25"
  """

  def test1() do
    Khf1.to_internal("khf1_f1.txt") |> IO.inspect()
    IO.puts("---")
    Khf1.to_internal("khf1_f2.txt") |> IO.inspect()
    IO.puts("---")
    Khf1.to_internal("khf1_f3.txt") |> IO.inspect()
    IO.puts("---")
  end



  @type row              :: integer    # sor száma (1-től n-ig)
  @type col              :: integer    # oszlop száma (1-től m-ig)
  @type field            :: {row, col} # egy parcella koordinátái
  @type tents_count_rows :: [integer]  # a sátrak száma soronként
  @type tents_count_cols :: [integer]  # a sátrak száma oszloponként
  @type trees            :: [field]    # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type puzzle_desc :: {tents_count_rows, tents_count_cols, trees} # a feladványleíró hármas
  @spec to_internal(file_name :: String.t()) :: puzzle_desc
  def to_internal(file_name) do
    file_content = file_name
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&String.match?(&1, ~r/^\s*$/))
    |> convert_first_line()
  end

  @spec to_tokens(String) :: [String]
  defp to_tokens(line) do
    line
    |> String.split(~r/[\s]/)
    |> Enum.reject(&(&1 === ""))
  end
  
  @spec convert_first_line([String]) :: puzzle_desc
  defp convert_first_line([first_line | rest]) do
    tentsCountCols =
      first_line
      |> to_tokens()
      |> Enum.map(&String.to_integer/1)

    {tentsCountRows, trees} = convert_rest(rest, 1)
    {tentsCountRows, tentsCountCols, trees}
  end

  @spec convert_rest(
    line_arr :: [String],
    line_idx :: integer,
    cs :: tents_count_cols,
    ts :: trees
  ) :: {tents_count_cols, trees}
  defp convert_rest(line_arr, line_idx, cs \\ [], ts \\ [])
  defp convert_rest([], _line_idx, cs, ts), do: {cs, ts}
  defp convert_rest([line | rest], line_idx, cs, ts) do
    {col, trees} = convert_line(line, line_idx)
    convert_rest(rest, line_idx + 1, cs ++ [col], ts ++ trees)
  end

  @spec convert_line(line :: String, line_idx :: integer) :: {integer, trees}
  defp convert_line(line, line_idx) do
    tokens = to_tokens(line)
    [col | cells] = tokens
    col = String.to_integer(col)
    {col, convert_cells(cells, line_idx)}
  end

  @spec convert_cells(
    cells :: [String],
    line_idx :: integer,
    col_idx :: integer,
    trees :: trees
  ) :: trees
  defp convert_cells(cells, line_idx, col_idx \\ 1, trees \\ [])
  defp convert_cells([], _line_idx, _col_idx, ts), do: ts
  defp convert_cells(["*" | rest], line_idx, col_idx, ts) do
    convert_cells(rest, line_idx, col_idx + 1, ts ++ [{line_idx, col_idx}])
  end
  defp convert_cells([_ | rest], line_idx, col_idx, ts) do
    convert_cells(rest, line_idx, col_idx + 1, ts)
  end
end
