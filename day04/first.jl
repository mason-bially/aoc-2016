workspace()
include("../util/aoc.jl")
using AoC
include("shared.jl")

aoc_4a(input) = sum(map(room_value, split(input)))

print(aoc_4a(@aoc_input))
