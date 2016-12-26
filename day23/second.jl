include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_23b(input) = aoc_23(input, [12, 0, 0, 0, 1])

print(aoc_23b(@aoc_input))

# 479007513
