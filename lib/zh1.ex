defmodule ZH do
  @spec szig([integer]) :: [[integer]]
  def szig(ls, res \\ [], curr \\ [])
  def szig([], res, []), do: res
  def szig([], res, curr), do: res ++ [curr]
  def szig([h | t], res, []) when h < 1, do: szig(t, res)
  def szig([h | t], res, curr) when h < 1, do: szig(t, res ++ [curr])
  def szig([h | t], res, curr), do: szig(t, res, curr ++ [h])

  @spec max_szig([integer]) :: integer
  def max_szig(ls, curr_max \\ 1)
  def max_szig([], curr_max), do: curr_max
  def max_szig([h | t], curr_max) when h > curr_max, do: max_szig(t, h)
  def max_szig([_h | t], curr_max), do: max_szig(t, curr_max)
  def szf(ls), do: szig(ls) |> Enum.map(&({Kernel.length(&1), max_szig(&1)}))

  def dec2hex_helper(d) when d < 10, do: d + ?0
  def dec2hex_helper(d), do: d + (?A - 10)
  def dec2hex(d), do: [dec2hex_helper(div d, 16), dec2hex_helper(rem d, 16)]


  # ACTUAL ZH

  def szsor([h | _] = xs, diff), do: szsor(xs, diff, h - diff, [])
  def szsor([], _diff, prev, res), do: {res, [prev]}
  def szsor([h | t], diff, prev, res) when prev + diff === h, do: szsor(t, diff, h, res ++ [h])
  def szsor(xs, _diff, prev, res), do: {res, [prev | xs]}

  def szamsor(xs, res \\ [])
  def szamsor([], res), do: res
  def szamsor([_h | t] = xs, res) do
    {r1, t1} = szsor(xs, 1)
    if(length(r1) < 2) do
      {r2, t2} = szsor(xs, -1)
      if(length(r2) < 2) do
        szamsor(t, res)
      else
        szamsor(t2, res ++ [r2])
      end
    else
      szamsor(t1, res ++ [r1])
    end
  end
end
