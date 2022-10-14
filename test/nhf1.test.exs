eval = fn (f, tss) ->
  r = (Khf1.to_internal(f) |> Nhf1.satrak() |> Enum.sort) |> (IO.inspect limit: :infinity)
  (r === Enum.sort(tss)) |> IO.inspect
end

IO.puts "--- 01dpty"
eval.("t01dpty.txt", [])

IO.puts "--- 01dcol"
eval.("t01dcol.txt", [[:n, :n], [:n, :s], [:s, :s]])

IO.puts "--- 01drow"
eval.("t01drow.txt", [[:e, :e], [:w, :e], [:w, :w]])

IO.puts "--- 01d"
eval.("test01d.txt", [[:w, :n, :e]])

IO.puts "--- 03d"
eval.("test03d.txt", [[:n, :e, :s, :w], [:n, :s, :n, :e], [:s, :n, :n, :e]])

IO.puts "--- 06d"
eval.("test06d.txt", [[:e, :e, :e, :s, :n, :w, :w, :s, :n, :w, :e, :s, :e, :e, :n]])

IO.puts "--- 07d"
eval.("test07d.txt",
  [
    [:e, :n, :e, :e, :e, :n, :s, :w, :e, :e, :e, :e, :n, :w, :s, :n, :w, :n, :s, :e],
    [:e, :n, :e, :e, :e, :s, :n, :w, :e, :e, :e, :e, :n, :w, :s, :n, :w, :n, :s, :e]
  ]
)

IO.puts "--- 13d"
eval.("test13d.txt",
  [
    [:e, :s, :w, :s, :e, :s, :w, :n, :s, :e, :n, :e, :n, :e, :n, :e, :w, :e, :n,
      :s, :w, :s, :n, :s, :w, :w, :n, :n, :w, :n, :w, :w, :s, :n, :s, :s, :n, :e,
      :w, :w, :s, :e, :n],
    [:e, :s, :w, :s, :e, :s, :w, :n, :s, :e, :n, :e, :n, :e, :n, :e, :w, :e, :n,
      :s, :w, :s, :n, :s, :w, :w, :n, :n, :w, :n, :w, :w, :s, :s, :n, :s, :n, :e,
      :w, :w, :s, :e, :n],
    [:w, :s, :w, :s, :e, :s, :w, :n, :s, :e, :n, :e, :n, :e, :n, :e, :w, :e, :n,
      :s, :w, :s, :n, :s, :w, :w, :n, :n, :w, :n, :e, :w, :s, :s, :n, :s, :n, :e,
      :w, :w, :s, :e, :n]
  ]
)

IO.puts "--- 15d"
eval.("test15d.txt",
[
  [:w, :s, :w, :w, :s, :n, :w, :n, :e, :s, :e, :e, :s, :e, :e, :e, :e, :e, :n,
    :w, :s, :s, :e, :s, :e, :e, :n, :n, :s, :s, :s, :w, :w, :s, :w, :n, :e, :s,
    :w, :s, :w, :e, :w, :w, :s, :e, :e, :n, :s, :w, :e, :e, :e, :w, :n, :s, :s,
    :n, :s, :w, :e, :n, :e, :e, :n]
]
)

IO.puts "--- 17d"
eval.("test17d.txt",
  [
    [:w, :s, :s, :e, :s, :e, :w, :n, :n, :s, :w, :s, :e, :e, :n, :s, :s, :n, :s,
      :n, :s, :w, :e, :e, :w, :e, :e, :s, :e, :n, :w, :w, :n, :s, :e, :n, :s, :e,
      :e, :w, :s, :w, :n, :e, :e, :e, :n, :n, :s, :n, :w, :w, :e, :n, :w, :n, :n,
      :e, :n]
  ]
)

IO.puts "--- 18d"
t18s =
[
  [:e, :e, :w, :e, :n, :s, :w, :n, :e, :e, :e, :n, :n, :n, :w, :w, :s, :e, :n,
    :n, :e, :e, :s, :e, :n, :s, :n, :s, :e, :w, :s, :s, :s, :e, :n, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :e, :w, :w, :e],
  [:e, :e, :w, :e, :n, :s, :w, :n, :e, :e, :e, :n, :n, :n, :w, :w, :s, :e, :n,
    :n, :e, :e, :s, :e, :n, :s, :n, :s, :e, :w, :s, :s, :s, :e, :n, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :s, :w, :n, :e],
  [:e, :e, :w, :e, :n, :s, :w, :n, :e, :e, :e, :n, :n, :n, :w, :w, :s, :e, :n,
    :n, :e, :e, :s, :e, :n, :s, :n, :s, :e, :w, :s, :s, :s, :e, :n, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :s, :w, :w, :n],
  [:e, :e, :w, :e, :n, :s, :w, :n, :e, :e, :e, :n, :n, :n, :w, :w, :s, :e, :n,
    :n, :n, :e, :w, :e, :n, :s, :s, :s, :e, :w, :s, :s, :s, :e, :n, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :e, :e, :s, :w, :e, :e],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :e, :e, :w, :e, :e],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :e, :s, :w, :e, :n],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :e, :w, :e, :e],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :s, :w, :e, :n],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :w, :s, :s,
    :e, :s, :n, :e, :w, :n, :s, :w, :e, :w, :e, :e],
  [:e, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :w, :s, :s,
    :e, :s, :n, :e, :w, :n, :s, :w, :s, :w, :e, :n],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :e, :e, :w, :e, :e],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :e, :s, :w, :e, :n],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :e, :w, :e, :e],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :s, :s, :n,
    :s, :s, :n, :s, :n, :n, :s, :w, :s, :w, :e, :n],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :w, :s, :s,
    :e, :s, :n, :e, :w, :n, :s, :w, :e, :w, :e, :e],
  [:w, :e, :w, :e, :s, :s, :w, :n, :e, :e, :e, :n, :s, :n, :w, :w, :s, :e, :n,
    :e, :e, :e, :w, :s, :n, :s, :s, :s, :w, :w, :e, :s, :s, :e, :e, :w, :s, :s,
    :e, :s, :n, :e, :w, :n, :s, :w, :s, :w, :e, :n]
]
eval.("test18d.txt", t18s)

IO.puts "---"
