workspace()
include("../util/aoc.jl")
using AoC
include("shared.jl")

aoc_4a(input) = input |>
  split |>
  _ -> map(room, _) |>
  _ -> filter(r -> contains(room_decipher(r), "northpole"), _) |>
  _ -> map(r -> r[:number], _)

print(aoc_4a(@aoc_input))
