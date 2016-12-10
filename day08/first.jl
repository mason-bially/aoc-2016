workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

aoc_8a(input) = countnz(gen_display(input))

print(aoc_8a(@aoc_input))
