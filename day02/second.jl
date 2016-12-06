include("../util/aoc.jl")
using AoC;

function aoc_2b(input)
  keypad = [
  [' ' ' ' '1' ' ' ' ']
  [' ' '2' '3' '4' ' ']
  ['5' '6' '7' '8' '9']
  [' ' 'A' 'B' 'C' ' ']
  [' ' ' ' 'D' ' ' ' ']
  ]
  code = ""
  x, y = 1, 2
  for c in join(split(input), ' ') * " "
      if c == 'U' && y != 1 && keypad[y-1, x] != ' '; y -= 1 end
      if c == 'D' && y != 5 && keypad[y+1, x] != ' '; y += 1 end
      if c == 'L' && x != 1 && keypad[y, x-1] != ' '; x -= 1 end
      if c == 'R' && x != 5 && keypad[y, x+1] != ' '; x += 1 end
      if c == ' '; code *= string(keypad[y, x]) end
  end
  return code
end

print(aoc_2b(@aoc_input))
