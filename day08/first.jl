workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_8a(input) = input |>
  split |>

print(aoc_8a(@aoc_input))
