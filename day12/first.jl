include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_12a(input) = aoc_12(input, [0, 0, 0, 0, 1])

print(aoc_12a(@aoc_input))

# 318077
