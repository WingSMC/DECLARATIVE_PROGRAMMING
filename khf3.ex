defmodule Khf3 do

  @moduledoc """
  Kemping helyessége
  @author "Dremák Gergely <gergely089@gmai.com>"
  @date   "2022-10-8"
  """

  @type row   :: integer                                            # sor száma (1-től n-ig)
  @type col   :: integer                                            # oszlop száma (1-től m-ig)
  @type field :: {row, col}                                         # egy parcella koordinátái
  @type tents_count_rows :: [integer]                               # a sátrak száma soronként
  @type tents_count_cols :: [integer]                               # a sátrak száma oszloponként
  @type trees       :: [field]                                      # a fákat tartalmazó parcellák koordinátái lexikálisan rendezve
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
  # Az {rs, cs, ts} = pd feladványleíró és a ds sátorirány-lista
  # alapján elvégzett ellenőrzés eredménye a cd hibaleíró, ahol
  #   rs a sátrak soronként elvárt számának a listája,
  #   cs a sátrak oszloponként elvárt számának a listája,
  #   ts a fákat tartalmazó parcellák koordinátájának a listája
  # Az {e_rows, e_cols, e_touch} = ed hármas elemei olyan
  # kulcs-érték párok, melyekben a kulcs a hiba jellegére utal, az
  # érték pedig a hibahelyeket felsoroló lista (üres, ha nincs hiba)
  def check_sol({rs, cs, ts}, ds) do
    {err_rows, err_cols, err_touch} = check_sol1({rs, cs, ts}, ds)
  end
end


p0 = {pd0, ts0} =
  { {[-1, 0, 0, -3, 0], [0, 0, -2, 0, 0], []}, [] }
p1 = {pd1, ts1} =
  { {[1, 0, 0, 3, 0], [0, 0, 2, 0, 0], []}, [] }
p2 = {pd2, ts2} =
  { {[1, 1, 0, 3, 0], [1, 0, 2, 0, 2], [{1, 2}, {3, 3}, {3, 5}, {5, 1}, {5, 5}]}, [:e,:s,:n,:n,:n] }
p3 = {pd3, ts3} =
  { {[1, 1, 0, 3, 0], [1, 0, 2, 0, 2], [{1, 2}, {3, 3}, {3, 5}, {5, 1}, {5, 5}]}, [:e,:e,:n,:n,:n] }
p4 = {pd4, ts4} =
  { {[1, 0, 2, 2, 0], [1, 0, 0, 2, 1], [{1, 2}, {3, 3}, {3, 5}, {5, 1}, {5, 5}]}, [:e,:e,:n,:n,:n] }
p5 = {pd5, ts5} =
  { {[1, 1, -1, 3, 0], [1, 0, -2, 0, 2], [{1, 2}, {3, 3}, {3, 5}, {5, 1}, {5, 5}]}, [:e,:s,:n,:n,:w] }

IO.puts "--- p0"
pd0 |> IO.inspect
ts0 |> IO.inspect
Khf2.to_external pd0, ts0, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd0, ts0) |> IO.inspect

IO.puts "--- p1"
pd1 |> IO.inspect
ts1 |> IO.inspect
Khf2.to_external pd1, ts1, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd1, ts1) |> IO.inspect


IO.puts "--- p2"
pd2 |> IO.inspect
ts2 |> IO.inspect
Khf2.to_external pd2, ts2, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd2, ts2) |> IO.inspect

IO.puts "--- p3"
pd3 |> IO.inspect
ts3 |> IO.inspect
Khf2.to_external pd3, ts3, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd3, ts3) |> IO.inspect

IO.puts "--- p4"
pd4 |> IO.inspect
ts4 |> IO.inspect
Khf2.to_external pd4, ts4, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd4, ts4) |> IO.inspect

IO.puts "--- p5"
pd5 |> IO.inspect
ts5 |> IO.inspect
Khf2.to_external pd5, ts5, "x.txt"; (File.read! "x.txt") |> IO.write
(Khf3.check_sol pd5, ts5) |> IO.inspect
IO.puts "---"
