defmodule Gy do
  @spec pow_min1(integer) :: -1 | 1
  defp pow_min1(n) when rem(n, 2) == 0, do: 1
  defp pow_min1(_), do: -1

  @spec gcd(integer, integer) :: integer
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))

  @spec len_loc([any]) :: integer
  def len_loc([]), do: 0
  def len_loc([_ | t]), do: 1 + len_loc(t)

  @spec pi(integer) :: float
  def pi(n) do
    4 *
      Enum.reduce(0..n, 0, fn i, acc ->
        acc + pow_min1(i) / (2 * i + 1)
      end)
  end

  @spec dec2rad(rad :: integer, integer, prev::list()) ::  [integer]
  def dec2rad(rad, n, prev \\ [])
  def dec2rad(rad, n, prev) when n < rad, do: [n | prev]
  def dec2rad(rad, n, prev), do: dec2rad(rad, div(n, rad), [rem(n, rad) | prev])

  @spec last_er([any]) :: {:ok, any} | :error
  def last_er([]), do: :error
  def last_er([a]), do: {:ok, a}
  def last_er([_ | b]), do: last_er(b)

  @spec last_ex([any]) :: any | nil
  def last_ex([]), do: nil
  def last_ex([a]), do: a
  def last_ex([_ | b]), do: last_ex(b)

  @spec at([any], integer) :: any | nil
  def at([a | _], 0), do: a
  def at([_ | b], n) when n > 0, do: at(b, n - 1)
  def at(_, _), do: nil

  @spec split([any], integer) :: {[any], [any]}
  def split(l, n) when n < 0, do: {[], l}
  def split(l, n), do: {take(l, n), drop(l, n)}

  @spec take([any], integer) :: [any]
  def take(_, n) when n <= 0, do: []
  def take([], _), do: []
  def take([a | b], n), do: [a | take(b, n - 1)]

  @spec drop([any], integer) :: [any]
  def drop(l, n) when n <= 0, do: l
  def drop([], _), do: []
  def drop([_ | b], n), do: drop(b, n - 1)

  @spec tails([any]) :: [[any]]
  def tails(l, acc \\ [])
  def tails([], acc), do: acc ++ [[]]
  def tails(l, acc), do: tails(tl(l), acc ++ [l])

  @spec parban([any]) :: [any]
  def parban(l, acc \\ [])
  def parban([], acc), do: acc
  def parban([h, h | t], acc), do: parban([h | t], acc ++ [h])
  def parban([_ | t], acc), do: parban(t, acc)

  @spec vertekek([any]) :: [any]
  def vertekek(l, acc \\ [])
  def vertekek([], acc), do: acc
  def vertekek([{:v, v} | t], acc), do: vertekek(t, acc ++ [v])
  def vertekek([_ | t], acc), do: vertekek(t, acc)

  # @spec dadogo(xs :: [any]) :: zss :: [[any]]
  # zss az xs lista összes olyan nemüres (folytonos) részlistájából
  # álló lista, amelyet vele azonos értékű részlista követ
  # dadogo([:a,:a,:a,2,3,3,:a,:b,:b,:b,:b]) === [[:a],[:a],[3],[:b],[:b,:b],[:b],[:b]]
  # TODO
end
