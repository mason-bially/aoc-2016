include("../util/aoc.jl")
using AoC;

function aoc_1a(input)
  entries = split(input, ", "; keep=false)

  x = 0; y = 0

  facing_y = true
  facing_neg = false

  for e in entries
    facing_y = ! facing_y
    if e[1] == 'R' && facing_y
      facing_neg = ! facing_neg
    elseif e[1] == 'L' && !facing_y
      facing_neg = ! facing_neg
    end

    v = parse(Int32, e[2:end])
    if facing_neg
      v = -v
    end

    if facing_y
      y += v
    else
      x += v
    end
  end

  return abs(x) + abs(y)
end

print(aoc_1a(@aoc_input))
