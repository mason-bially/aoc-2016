workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_8b(input) = input |>
  split |>

print(aoc_8b(@aoc_input))
