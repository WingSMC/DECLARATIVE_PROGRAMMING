defmodule Gyak do
  @spec pow_min1(integer) :: -1 | 1
  defp pow_min1(n) when rem(n, 2) == 0, do: 1
  defp pow_min1(_), do: -1

  @spec gcd(integer, integer) :: integer
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))

  @spec len([any]) :: integer
  def len([]), do: 0
  def len([_ | t]), do: 1 + len(t)

  @spec pi(integer) :: float
  def pi(n) do
    4 *
      Enum.reduce(0..n, 0, fn i, acc ->
        acc + pow_min1(i) / (2 * i + 1)
      end)
  end

  @spec dec2rad(rad :: integer, n :: integer) :: integer
  def dec2rad(rad, n, prev \\ [])
  def dec2rad(rad, n, prev) when n < rad, do: [n | prev]
  def dec2rad(rad, n, prev), do: dec2rad(rad, div(n, rad), [rem(n, rad) | prev])
end
