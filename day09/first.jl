workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

function aoc_9a(input)
  i = 0
  in_marker = false
  to_count = 0
  multiplier = 0
  parse_str = ""
  for c in input
    if to_count == 0 && c == '('
      in_marker = true
    elseif in_marker && c == 'x'
      to_count = parse(parse_str)
      parse_str = "";
    elseif in_marker && c == ')'
      in_marker = false
      multiplier = parse(parse_str)
      parse_str = "";
    elseif in_marker
      parse_str *= string(c)
    elseif to_count != 0 && !isspace(c)
      i += multiplier
      to_count -= 1
    elseif !isspace(c)
      i += 1
    end
  end
  return i
end

print(aoc_9a(@aoc_input))
