using Iterators
include("../util/aoc.jl")
using AoC;

function aoc_3a(input)
  valid = 0
  for sides in partition(map(parse, split(input)), 3)
    m = maximum(sides)
    valid += (sum(sides) - m) > m
  end
  return valid
end

print(aoc_3a(@aoc_input))
