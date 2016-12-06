using Iterators
include("../util/aoc.jl")
using AoC

function aoc_3b(input)
  valid = 0
  for groups in map(a -> reshape([a...], 3, 3), partition(map(parse, split(input)), 9))
    for sides in [groups[1,:], groups[2,:], groups[3,:]]
      m = maximum(sides)
      valid += (sum(sides) - m) > m
    end
  end
  return valid
end

print(aoc_3b(@aoc_input))
