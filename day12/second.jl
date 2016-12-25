workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_12b(input) = aoc_12(input, [0, 0, 1, 0, 1])

print(aoc_12b(@aoc_input))

# 9227731
