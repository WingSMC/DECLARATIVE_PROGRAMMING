defmodule Khf1 do
  @moduledoc """
  Kemping
  @author "Dremák Gergely <gergely089@gmail.com>"
  @date   "2022-9-30"
  ...
  """

  @type row            :: integer                                 # sor száma (1-től n-ig)
  @type col            :: integer                                 # oszlop száma (1-től m-ig)
  @type field          :: {row, col}                              # egy parcella koordinátái
  @type tentsCountRows :: [integer]                               # a sátrak száma soronként
  @type tentsCountCols :: [integer]                               # a sátrak száma oszloponként
  @type trees          :: [field]                                 # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
  @type puzzle_desc    :: {tentsCountRows, tentsCountCols, trees} # a feladványleíró hármas

  @spec to_internal(file::String.t) :: pd::puzzle_desc
  # A file fájlban szövegesen ábrázolt feladvány leírója pd
end
