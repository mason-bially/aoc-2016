include("../util/aoc.jl")
using AoC;

function aoc_2a(input)
  keypad = [
  [1 2 3]
  [4 5 6]
  [7 8 9]
  ]
  code = ""
  x, y = 2, 2
  for c in join(split(input), ' ') * " "
      if c == 'U' && y != 1; y -= 1 end
      if c == 'D' && y != 3; y += 1 end
      if c == 'L' && x != 1; x -= 1 end
      if c == 'R' && x != 3; x += 1 end
      if c == ' '; code *= string(keypad[y, x]) end
  end
  return code
end

print(aoc_2a(@aoc_input))
