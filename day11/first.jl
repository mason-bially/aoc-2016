workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

function aoc_11a(input)
  comps = parse_components(input)
  return solve_comps(comps)
end

print(aoc_11a(@aoc_input))
