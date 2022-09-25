defmodule Khf2 do

  @moduledoc """
  Kemping térképe
  @author "Dremák Gergely <gergely089@gmail.com>"
  @date   "2022-09-25"
  """

  @type row   :: integer    # sor száma (1-től n-ig)
  @type col   :: integer    # oszlop száma (1-től m-ig)
  @type field :: {row, col} # egy parcella koordinátái
  @type tents_count_rows :: [integer] # a sátrak száma soronként
  @type tents_count_cols :: [integer] # a sátrak száma oszloponként
  @type trees       :: [field]   # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type puzzle_desc :: {tents_count_rows, tents_count_cols, trees} # a feladványleíró hármas
  @type dir       :: :n | :e | :s | :w # a sátorpozíciók iránya: north, east, south, west
  @type tent_dirs :: [dir]             # a sátorpozíciók irányának listája a fákhoz képest

  @spec to_external(pd::puzzle_desc, ds::tent_dirs, file::String.t) :: :ok
  # A pd = {rs, cs, ts} feladványleíró és a ds sátorirány-lista alapján
  # a feladvány szöveges ábrázolását írja ki a file fájlba, ahol
  #   rs a sátrak soronkénti számának a listája,
  #   cs a sátrak oszloponkénti számának a listája,
  #   ts a fákat tartalmazó parcellák koordinátájának listája

end
