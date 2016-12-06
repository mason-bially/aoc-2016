include("../util/aoc.jl")
using AoC;

function aoc_6a(input)
  lines = split(input)
  w = length(lines[1])
  a = zeros(UInt32, w, 26)
  _c_base = Int('a')
  for l in lines
    for (i, x) in enumerate(l)
      a[i, Int(x) + 1 - _c_base] += 1;
    end
  end
  s = ""
  for i in 1:w
    s *= string(Char(_c_base - 1 +
      maximum(map(x -> (x[2], x[1]), enumerate(a[i, :])))[2]))
  end
  return s
end

print(aoc_6a(@aoc_input))
